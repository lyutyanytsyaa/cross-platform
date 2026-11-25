// Моделі даних інтернет-магазину

class User {
  final int id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});
}

class Product {
  final int id;
  final String name;
  final double price;

  const Product({required this.id, required this.name, required this.price});
}

class Order {
  final int id;
  final String date;
  final List<String> items;
  final double total;

  const Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
  });
}