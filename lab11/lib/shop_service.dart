import 'models.dart';

// Імітація сервера інтернет-магазину.
// Кожен метод асинхронний: "чекає відповідь" через Future.delayed
// і лише потім повертає дані.
class ShopService {
  // Якщо true — getUser() завершиться помилкою (для перевірки try/catch)
  bool simulateError = false;

  /// Інформація про користувача (відповідь через 2 секунди)
  Future<User> getUser() async {
    await Future.delayed(const Duration(seconds: 2));

    if (simulateError) {
      throw Exception('Сервер не відповідає: не вдалося отримати користувача');
    }

    return const User(id: 1, name: 'Аніта Лютяниця', email: 'anita@shop.ua');
  }

  /// Список доступних товарів (відповідь через 3 секунди)
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 3));

    return const [
      Product(id: 1, name: 'Навушники', price: 1299.00),
      Product(id: 2, name: 'Чохол для телефону', price: 349.50),
      Product(id: 3, name: 'Павербанк', price: 899.00),
      Product(id: 4, name: 'Розумний годинник', price: 2499.99),
    ];
  }

  /// Історія замовлень користувача (відповідь через 2 секунди)
  Future<List<Order>> getOrders() async {
    await Future.delayed(const Duration(seconds: 2));

    return const [
      Order(
        id: 1001,
        date: '05.11.2026',
        items: ['Навушники', 'Чохол для телефону'],
        total: 1648.50,
      ),
      Order(
        id: 1002,
        date: '18.11.2026',
        items: ['Павербанк'],
        total: 899.00,
      ),
    ];
  }
}