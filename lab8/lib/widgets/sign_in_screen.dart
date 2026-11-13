import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'reset_password_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Стилі тексту беремо з теми
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Google-flutter-logo.png/640px-Google-flutter-logo.png',
                height: 60,
                errorBuilder: (context, error, stackTrace) => const FlutterLogo(
                  size: 60,
                  style: FlutterLogoStyle.horizontal,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              Text('Email:', style: textTheme.labelMedium),
              const SizedBox(height: 4),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'example@mail.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // Поле для пароля
              Text('Password:', style: textTheme.labelMedium),
              const SizedBox(height: 4),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return const AlertDialog(
                              title: Text('Message'),
                              content: Text('Need to implement'),
                            );
                          },
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text('Reset password'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}