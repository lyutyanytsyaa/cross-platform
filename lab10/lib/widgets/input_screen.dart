import 'package:flutter/material.dart';
import './preview_screen.dart';

// Перший екран: введення тексту та вибір розміру шрифту
class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _textController = TextEditingController();
  double _fontSize = 16;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _openPreview() async {
    // Відкриваємо другий екран і чекаємо результат:
    // true — натиснули Ok, false — Cancel, null — повернулись без кнопок
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    );

    if (!mounted) return;

    final String message;
    if (result == true) {
      message = 'Cool!';
    } else if (result == false) {
      message = "Let's try something else";
    } else {
      message = "Don't know what to say";
    }

    _showMessage(message);
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          // Іконка робота з папки assets проєкту
          icon: Image.asset(
            'assets/robot.png',
            width: 50,
            height: 50,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.smart_toy, size: 50),
          ),
          content: Text(message, textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text previewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Поле для введення тексту
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text',
                helperText: 'Enter some text',
              ),
            ),
            const SizedBox(height: 16),

            // Розмір шрифту
            Row(
              children: [
                Text('Font size: ${_fontSize.round()}'),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Перехід на екран попереднього перегляду
            FilledButton(
              onPressed: _openPreview,
              child: const Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }
}