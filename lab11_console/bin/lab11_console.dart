// Лабораторна робота №11. Основи асинхронного програмування
// Консольний застосунок, який імітує отримання даних з інтернет-магазину.

import 'dart:io';

// ---------------------------------------------------------------------------
// Моделі даних
// ---------------------------------------------------------------------------

class User {
  final int id;
  final String name;
  final String email;

  User(this.id, this.name, this.email);

  @override
  String toString() => '$name ($email), id: $id';
}

class Product {
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() => '$name — ${price.toStringAsFixed(2)} грн';
}

class Order {
  final int id;
  final String date;
  final List<String> items;
  final double total;

  Order(this.id, this.date, this.items, this.total);

  @override
  String toString() =>
      'Замовлення №$id від $date: ${items.join(', ')} '
          '(разом ${total.toStringAsFixed(2)} грн)';
}

// ---------------------------------------------------------------------------
// Імітація сервера інтернет-магазину
// ---------------------------------------------------------------------------

class ShopService {
  /// Якщо true — getUser() завершиться помилкою
  bool simulateError = false;

  /// Інформація про користувача (відповідь через 2 секунди)
  Future<User> getUser() async {
    print('  → getUser(): запит надіслано...');
    await Future.delayed(const Duration(seconds: 2));

    if (simulateError) {
      throw Exception('Сервер не відповідає: не вдалося отримати користувача');
    }

    print('  ← getUser(): відповідь отримано');
    return User(1, 'Аніта Лютяниця', 'anita@shop.ua');
  }

  /// Список доступних товарів (відповідь через 3 секунди)
  Future<List<Product>> getProducts() async {
    print('  → getProducts(): запит надіслано...');
    await Future.delayed(const Duration(seconds: 3));

    print('  ← getProducts(): відповідь отримано');
    return [
      Product(1, 'Навушники', 1299.00),
      Product(2, 'Чохол для телефону', 349.50),
      Product(3, 'Павербанк', 899.00),
      Product(4, 'Розумний годинник', 2499.99),
    ];
  }

  /// Історія замовлень користувача (відповідь через 2 секунди)
  Future<List<Order>> getOrders() async {
    print('  → getOrders(): запит надіслано...');
    await Future.delayed(const Duration(seconds: 2));

    print('  ← getOrders(): відповідь отримано');
    return [
      Order(1001, '05.11.2026', ['Навушники', 'Чохол для телефону'], 1648.50),
      Order(1002, '18.11.2026', ['Павербанк'], 899.00),
    ];
  }
}

// ---------------------------------------------------------------------------
// Виведення результатів
// ---------------------------------------------------------------------------

void printData(User user, List<Product> products, List<Order> orders) {
  print('\nКористувач:');
  print('  $user');

  print('\nТовари:');
  for (final product in products) {
    print('  • $product');
  }

  print('\nІсторія замовлень:');
  for (final order in orders) {
    print('  • $order');
  }
}

String seconds(Stopwatch s) =>
    (s.elapsedMilliseconds / 1000).toStringAsFixed(1);

// ---------------------------------------------------------------------------
// 1. Послідовне виконання: кожен запит чекає завершення попереднього
// ---------------------------------------------------------------------------

Future<void> loadSequential(ShopService service) async {
  print('\n=== 1. ПОСЛІДОВНЕ ЗАВАНТАЖЕННЯ ===');
  final stopwatch = Stopwatch()..start();

  try {
    final user = await service.getUser();
    final products = await service.getProducts();
    final orders = await service.getOrders();

    printData(user, products, orders);
  } catch (e) {
    print('\nПомилка: $e');
  } finally {
    stopwatch.stop();
    print('\nЧас виконання: ${seconds(stopwatch)} с');
  }
}

// ---------------------------------------------------------------------------
// 2. Паралельне (конкурентне) виконання: усі запити стартують одночасно
// ---------------------------------------------------------------------------

Future<void> loadParallel(ShopService service) async {
  print('\n=== 2. ПАРАЛЕЛЬНЕ ЗАВАНТАЖЕННЯ (Future.wait) ===');
  final stopwatch = Stopwatch()..start();

  try {
    final results = await Future.wait([
      service.getUser(),
      service.getProducts(),
      service.getOrders(),
    ]);

    final user = results[0] as User;
    final products = results[1] as List<Product>;
    final orders = results[2] as List<Order>;

    printData(user, products, orders);
  } catch (e) {
    print('\nПомилка: $e');
  } finally {
    stopwatch.stop();
    print('\nЧас виконання: ${seconds(stopwatch)} с');
  }
}

// ---------------------------------------------------------------------------
// 3. Обробка помилки: сервер "не відповідає"
// ---------------------------------------------------------------------------

Future<void> loadWithError(ShopService service) async {
  print('\n=== 3. ОБРОБКА ПОМИЛКИ (try / catch / finally) ===');
  service.simulateError = true;

  try {
    final user = await service.getUser();
    print('Користувач: $user'); // не виконається через помилку
  } catch (e) {
    print('\nПомилку перехоплено: $e');
  } finally {
    service.simulateError = false;
    print('Блок finally виконано (виконується завжди)');
  }
}

// ---------------------------------------------------------------------------
// Точка входу
// ---------------------------------------------------------------------------

Future<void> main() async {
  print('Інтернет-магазин: демонстрація асинхронного програмування');

  final service = ShopService();

  await loadSequential(service);
  await loadParallel(service);
  await loadWithError(service);

  print('\nПрограму завершено.');

  // Чекаємо натискання Enter, щоб вікно не закрилося одразу
  stdout.write('\nНатисніть Enter, щоб закрити вікно...');
  stdin.readLineSync();
}