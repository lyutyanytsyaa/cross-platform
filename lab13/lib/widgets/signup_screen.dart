import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../api_service.dart';
import '../validators.dart';
import './result_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Контролери: через них читаємо введений текст
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // true, поки триває запит до сервера
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      final response = await ApiService.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      await showResultDialog(
        context,
        success: true,
        message:
        'Дані реєстрації надіслано (код відповіді ${response.statusCode})',
      );

      // Після успіху повертаємось на екран входу
      if (!mounted) return;
      Navigator.pop(context);
    } on DioException catch (e) {
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
                  'Реєстрація',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 16),

                // Ім'я
                Text("Ім'я:", style: textTheme.labelMedium),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _nameController,
                  validator: Validators.required,
                  decoration: const InputDecoration(
                    hintText: "Ваше ім'я",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),

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

                // Sign up: надсилає дані на сервер
                ElevatedButton(
                  onPressed: _isSending ? null : _register,
                  child: _isSending
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Зареєструватися'),
                ),
                const SizedBox(height: 16),

                // Повернення на екран авторизації
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Назад'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}