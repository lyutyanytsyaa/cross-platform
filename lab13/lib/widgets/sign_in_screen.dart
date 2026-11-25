import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../api_service.dart';
import '../validators.dart';
import './result_dialog.dart';
import './signup_screen.dart';
import './reset_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  // Контролери: через них читаємо введений текст
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // true, поки триває запит до сервера
  bool _isSending = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // 1) Перевіряємо форму
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      // 2) Надсилаємо дані на сервер і чекаємо відповідь
      final response = await ApiService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      await showResultDialog(
        context,
        success: true,
        message: 'Дані входу надіслано (код відповіді ${response.statusCode})',
      );
    } on DioException catch (e) {
      // 3) Помилка мережі або сервера
      if (!mounted) return;
      await showResultDialog(
        context,
        success: false,
        message: 'Не вдалося надіслати дані: ${e.message}',
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Логотип
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Google-flutter-logo.png/640px-Google-flutter-logo.png',
                  height: 60,
                  errorBuilder: (context, error, stackTrace) =>
                  const FlutterLogo(
                    size: 60,
                    style: FlutterLogoStyle.horizontal,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Вхід',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 16),

                // Email
                Text('Електронна пошта:', style: textTheme.labelMedium),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  decoration: const InputDecoration(
                    hintText: 'example@mail.com',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 12),

                // Пароль
                Text('Пароль:', style: textTheme.labelMedium),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: Validators.password,
                  decoration: const InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    // Login: надсилає дані на сервер
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSending ? null : _login,
                        child: _isSending
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                            : const Text('Увійти'),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Перехід на екран відновлення паролю
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const ResetPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text('Забули пароль?'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Перехід на екран реєстрації
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text('Зареєструватися'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}