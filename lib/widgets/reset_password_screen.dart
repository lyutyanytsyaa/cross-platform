import 'package:flutter/material.dart';
import './app_ui.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      showResultDialog(
        context,
        success: false,
        title: 'Немає email',
        message: 'Будь ласка, введіть свій email',
      );
      return;
    }

    await showResultDialog(
      context,
      success: true,
      title: 'Лист надіслано!',
      message: 'Інструкції для відновлення пароля надіслано на $email',
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
          const Text(
            'Відновлення пароля',
            textAlign: TextAlign.center,
            style: AppTextStyles.title,
          ),
          const SizedBox(height: 6),
          const Text(
            'Введіть email, і ми надішлемо посилання для скидання',
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 28),

          AppTextField(
            label: 'Email',
            hint: 'example@mail.com',
            icon: Icons.mail_outline_rounded,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),

          // Скидання пароля
          ElevatedButton(
            onPressed: _reset,
            child: const Text('Скинути пароль'),
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