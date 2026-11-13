import 'package:flutter/material.dart';
import '../validators.dart';
import './signup_screen.dart';
import './reset_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Ключ форми: через нього запускаємо валідацію всіх полів
  final _formKey = GlobalKey<FormState>();

  void _login() {
    // validate() викликає validator кожного TextFormField
    // і повертає true, якщо помилок немає
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return const AlertDialog(
            title: Text('Успіх'),
            content: Text('Ви успішно увійшли в акаунт'),
          );
        },
      );
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
            // Після першої взаємодії помилки оновлюються під час вводу
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
                const SizedBox(height: 12),

                // Пароль
                Text('Пароль:', style: textTheme.labelMedium),
                const SizedBox(height: 4),
                TextFormField(
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
                    // Підтвердження авторизації
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _login,
                        child: const Text('Увійти'),
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