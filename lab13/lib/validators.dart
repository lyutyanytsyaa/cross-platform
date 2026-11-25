// Функції валідації полів форми.
// Кожна повертає текст помилки або null, якщо значення правильне.

class Validators {
  // Мінімальна довжина пароля
  static const minPasswordLength = 7;

  // Шаблон для перевірки email: щось@щось.щось
  static final _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)*\.[a-zA-Z]{2,}$');

  /// Обов'язкове поле: не може бути порожнім
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Це поле обов'язкове";
    }
    return null;
  }

  /// Email: обов'язковий і має правильний формат
  static String? email(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (!_emailRegExp.hasMatch(value!.trim())) {
      return 'Введіть коректну електронну пошту';
    }
    return null;
  }

  /// Пароль: обов'язковий і не коротший за 7 символів
  static String? password(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (value!.length < minPasswordLength) {
      return 'Пароль має містити щонайменше $minPasswordLength символів';
    }
    return null;
  }
}