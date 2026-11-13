import 'package:flutter/material.dart';

// Другий екран: попередній перегляд тексту вказаного розміру
class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    super.key,
    required this.text,
    required this.fontSize,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Текст потрібного розміру
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ok: закрити екран і повернути true
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('OK'),
                  ),
                  const SizedBox(width: 8),

                  // Cancel: закрити екран і повернути false
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}