import 'package:flutter/material.dart';
import 'models.dart';
import 'shop_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Інтернет-магазин',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const ShopScreen(),
    );
  }
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final _service = ShopService();

  // Стан екрана
  bool _isLoading = false;
  String? _error;
  String? _timeInfo;

  User? _user;
  List<Product> _products = [];
  List<Order> _orders = [];

  /// Очищує попередні результати перед новим завантаженням
  void _startLoading() {
    setState(() {
      _isLoading = true;
      _error = null;
      _timeInfo = null;
      _user = null;
      _products = [];
      _orders = [];
    });
  }

  /// ПОСЛІДОВНЕ завантаження: кожен запит чекає завершення попереднього.
  /// Загальний час = 2 + 3 + 2 = ~7 секунд.
  Future<void> _loadSequential() async {
    _startLoading();
    final stopwatch = Stopwatch()..start();

    try {
      final user = await _service.getUser();
      final products = await _service.getProducts();
      final orders = await _service.getOrders();

      setState(() {
        _user = user;
        _products = products;
        _orders = orders;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      stopwatch.stop();
      setState(() {
        _isLoading = false;
        _timeInfo = 'Послідовно: ${_seconds(stopwatch)} с';
      });
    }
  }

  /// ПАРАЛЕЛЬНЕ (конкурентне) завантаження: усі запити стартують одночасно,
  /// Future.wait чекає, поки завершаться всі.
  /// Загальний час = найдовший запит = ~3 секунди.
  Future<void> _loadParallel() async {
    _startLoading();
    final stopwatch = Stopwatch()..start();

    try {
      final results = await Future.wait([
        _service.getUser(),
        _service.getProducts(),
        _service.getOrders(),
      ]);

      setState(() {
        _user = results[0] as User;
        _products = results[1] as List<Product>;
        _orders = results[2] as List<Order>;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      stopwatch.stop();
      setState(() {
        _isLoading = false;
        _timeInfo = 'Паралельно: ${_seconds(stopwatch)} с';
      });
    }
  }

  String _seconds(Stopwatch s) =>
      (s.elapsedMilliseconds / 1000).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Аніта ПР 11: Інтернет-магазин'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Перемикач помилки
          SwitchListTile(
            title: const Text('Імітувати помилку сервера'),
            subtitle: const Text('getUser() кине виняток'),
            value: _service.simulateError,
            onChanged: _isLoading
                ? null
                : (value) => setState(() => _service.simulateError = value),
          ),
          const SizedBox(height: 8),

          // Кнопки завантаження
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _loadSequential,
                  child: const Text('Послідовно'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _isLoading ? null : _loadParallel,
                  child: const Text('Паралельно'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Індикатор завантаження
          if (_isLoading)
            const Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text('Завантаження даних з сервера...'),
              ],
            ),

          // Час виконання
          if (_timeInfo != null)
            Text(
              '⏱ $_timeInfo',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 8),

          // Помилка
          if (_error != null)
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: ListTile(
                leading: const Icon(Icons.error_outline),
                title: const Text('Помилка'),
                subtitle: Text(_error!),
              ),
            ),

          // Користувач
          if (_user != null) ...[
            _sectionTitle('Користувач'),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(_user!.name),
                subtitle: Text(_user!.email),
              ),
            ),
          ],

          // Товари
          if (_products.isNotEmpty) ...[
            _sectionTitle('Товари'),
            for (final product in _products)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: Text(product.name),
                  trailing: Text('${product.price.toStringAsFixed(2)} ₴'),
                ),
              ),
          ],

          // Замовлення
          if (_orders.isNotEmpty) ...[
            _sectionTitle('Історія замовлень'),
            for (final order in _orders)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text('Замовлення №${order.id} від ${order.date}'),
                  subtitle: Text(order.items.join(', ')),
                  trailing: Text('${order.total.toStringAsFixed(2)} ₴'),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}