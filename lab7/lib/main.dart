import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Аніта ПР 7 Варіант 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _red = 206;
  int _green = 178;
  int _blue = 230;

  @override
  Widget build(BuildContext context) {
    final color = Color.fromARGB(255, _red, _green, _blue);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),

            ColorPreview(color: color),
            const SizedBox(height: 16),

            Text(
              _toHex(_red, _green, _blue),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            ColorSlider(
              label: 'Red',
              value: _red,
              activeColor: Colors.red,
              onChanged: (value) => setState(() => _red = value),
            ),
            ColorSlider(
              label: 'Green',
              value: _green,
              activeColor: Colors.green,
              onChanged: (value) => setState(() => _green = value),
            ),
            ColorSlider(
              label: 'Blue',
              value: _blue,
              activeColor: Colors.blue,
              onChanged: (value) => setState(() => _blue = value),
            ),
          ],
        ),
      ),
    );
  }

  String _toHex(int r, int g, int b) {
    String hex(int v) => v.toRadixString(16).padLeft(2, '0').toUpperCase();
    return '#${hex(r)}${hex(g)}${hex(b)}';
  }
}

class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        color: color,
      ),
    );
  }
}

class ColorSlider extends StatelessWidget {
  const ColorSlider({
    super.key,
    required this.label,
    required this.value,
    required this.activeColor,
    required this.onChanged,
  });

  final String label;
  final int value;
  final Color activeColor;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: '$label: ',
            children: [
              TextSpan(
                text: '$value',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 255,
          divisions: 255,
          activeColor: activeColor,
          onChanged: (newValue) => onChanged(newValue.round()),
        ),
      ],
    );
  }
}