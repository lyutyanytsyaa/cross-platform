import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../api_service.dart';
import '../validators.dart';
import './result_dialog.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // Контролер: через нього читаємо введений email
  final _emailController = TextEditingController();

  // true, поки триває запит до сервера
  bool _isSending = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      final response = await ApiService.resetPassword(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      await showResultDialog(
        context,
        success: true,
        message:
        'Запит на скидання пароля надіслано (код відповіді ${response.statusCode})',
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
                  'Відновлення пароля',
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
                const SizedBox(height: 16),

                // Reset: надсилає дані на сервер
                ElevatedButton(
                  onPressed: _isSending ? null : _reset,
                  child: _isSending
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Скинути пароль'),
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