import 'package:flutter/material.dart';
import './app_ui.dart';
import './signup_screen.dart';
import './reset_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Тестові дані для входу
  static const _testEmail = '1';
  static const _testPassword = '1';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty && password.isEmpty) {
      showResultDialog(
        context,
        success: false,
        title: 'Вхід не здійснено',
        message: 'Введіть дані',
      );
      return;
    }

    if (email.isEmpty) {
      showResultDialog(
        context,
        success: false,
        title: 'Немає email',
        message: 'Будь ласка, введіть email',
      );
      return;
    }

    if (password.isEmpty) {
      showResultDialog(
        context,
        success: false,
        title: 'Немає пароля',
        message: 'Будь ласка, введіть пароль',
      );
      return;
    }

    if (email != _testEmail || password != _testPassword) {
      showResultDialog(
        context,
        success: false,
        title: 'Помилка входу',
        message: 'Невірний пароль або email',
      );
      return;
    }

    showResultDialog(
      context,
      success: true,
      title: 'Готово!',
      message: 'Ви успішно увійшли',
      // перехід на застосунок
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppLogo(
            title: 'З поверненням!',
            subtitle: 'Увійдіть у свій акаунт',
          ),
          const SizedBox(height: 28),

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

          // Перехід на відновлення паролю
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordScreen(),
                  ),
                );
              },
              child: const Text('Забули пароль?'),
            ),
          ),
          const SizedBox(height: 4),

          // Вхід
          ElevatedButton(
            onPressed: _login,
            child: const Text('Увійти'),
          ),
          const SizedBox(height: 18),

          Row(
            children: const [
              Expanded(child: Divider(color: AppColors.accentLight)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'або',
                  style: TextStyle(color: AppColors.textLight),
                ),
              ),
              Expanded(child: Divider(color: AppColors.accentLight)),
            ],
          ),
          const SizedBox(height: 18),

          // Перехід на реєстрацію
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              );
            },
            child: const Text('Створити акаунт'),
          ),
          const SizedBox(height: 20),

          // Підказка з тестовими даними
          /*Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.field,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: AppColors.textLight,
                ),
                SizedBox(width: 6),
                Text(
                  'Тестовий вхід: email 1, пароль 1',
                  style: TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}