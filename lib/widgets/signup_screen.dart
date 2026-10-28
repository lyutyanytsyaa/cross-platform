import 'package:flutter/material.dart';
import './app_ui.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    // Збираємо список незаповнених полів
    final missing = <String>[];
    if (_nameController.text.trim().isEmpty) missing.add("ім'я");
    if (_emailController.text.trim().isEmpty) missing.add('email');
    if (_passwordController.text.isEmpty) missing.add('пароль');

    if (missing.isNotEmpty) {
      showResultDialog(
        context,
        success: false,
        title: 'Заповніть усі поля',
        message: 'Не вказано: ${missing.join(', ')}',
      );
      return;
    }

    // Дані нікуди не записуються — просто показуємо успіх
    await showResultDialog(
      context,
      success: true,
      title: 'Реєстрацію завершено!',
      message: 'Акаунт успішно створено',
    );

    // Після закриття діалогу повертаємось на екран входу
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppLogo(
            title: 'Реєстрація',
            subtitle: 'Створіть новий акаунт',
          ),
          const SizedBox(height: 28),

          AppTextField(
            label: "Ім'я",
            hint: 'Ваше імʼя',
            icon: Icons.person_outline_rounded,
            controller: _nameController,
          ),
          const SizedBox(height: 16),

          AppTextField(
            label: 'Email',
            hint: 'example@mail.com',
            icon: Icons.mail_outline_rounded,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          AppTextField(
            label: 'Пароль',
            hint: '********',
            icon: Icons.lock_outline_rounded,
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 24),

          // Реєстрація
          ElevatedButton(
            onPressed: _register,
            child: const Text('Зареєструватися'),
          ),
          const SizedBox(height: 12),

          // Повернення на екран авторизації
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Назад до входу'),
          ),
        ],
      ),
    );
  }
}