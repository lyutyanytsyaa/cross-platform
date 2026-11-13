import 'package:flutter/material.dart';
import '../validators.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Ключ форми: через нього запускаємо валідацію всіх полів
  final _formKey = GlobalKey<FormState>();

  Future<void> _reset() async {
    if (_formKey.currentState!.validate()) {
      // Чекаємо, поки користувач закриє діалог
      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Успіх'),
            content: const Text('Посилання для скидання пароля надіслано на вашу пошту'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      // Після закриття діалогу повертаємось на екран входу
      if (!mounted) return;
      Navigator.pop(context);
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
                Text('Email:', style: textTheme.labelMedium),
                const SizedBox(height: 4),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  decoration: const InputDecoration(
                    hintText: 'example@mail.com',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),

                // Запуск процедури скидання пароля
                ElevatedButton(
                  onPressed: _reset,
                  child: const Text('Скинути пароль'),
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