import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                'Sign Up',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              Text('Name:', style: textTheme.labelMedium),
              const SizedBox(height: 4),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Your name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 12),

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

              ElevatedButton(
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
                child: const Text('Sign up'),
              ),
              const SizedBox(height: 16),

              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}