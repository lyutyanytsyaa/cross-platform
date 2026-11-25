import 'package:flutter/material.dart';

/// Кути контейнера
enum Corner { topLeft, topRight, bottomLeft, bottomRight }

/// Модель стану: зберігає радіуси заокруглення чотирьох кутів.
/// ChangeNotifier уміє повідомляти віджети про зміни через notifyListeners().
class CornersModel extends ChangeNotifier {
  static const double maxRadius = 100;

  double _topLeft = 0;
  double _topRight = 0;
  double _bottomLeft = 0;
  double _bottomRight = 0;

  /// Повертає радіус потрібного кута
  double radiusOf(Corner corner) {
    return switch (corner) {
      Corner.topLeft => _topLeft,
      Corner.topRight => _topRight,
      Corner.bottomLeft => _bottomLeft,
      Corner.bottomRight => _bottomRight,
    };
  }

  /// Змінює радіус кута і повідомляє всіх слухачів
  void setRadius(Corner corner, double value) {
    switch (corner) {
      case Corner.topLeft:
        _topLeft = value;
      case Corner.topRight:
        _topRight = value;
      case Corner.bottomLeft:
        _bottomLeft = value;
      case Corner.bottomRight:
        _bottomRight = value;
    }
    notifyListeners(); // ← віджети, що слухають модель, перемалюються
  }

  /// Готовий BorderRadius для контейнера
  BorderRadius get borderRadius => BorderRadius.only(
    topLeft: Radius.circular(_topLeft),
    topRight: Radius.circular(_topRight),
    bottomLeft: Radius.circular(_bottomLeft),
    bottomRight: Radius.circular(_bottomRight),
  );
}