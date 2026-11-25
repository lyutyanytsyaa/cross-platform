import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/corners_model.dart';
import 'widgets/rounded_box_section.dart';
import 'widgets/sliders_section.dart';

void main() {
  runApp(
    // Створюємо модель і "роздаємо" її всьому дереву віджетів
    ChangeNotifierProvider(
      create: (context) => CornersModel(),
      child: const MyApp(),
    ),
  );
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
      home: const MyHomePage(title: 'Аніта ПР 12 Варіант 2'),
    );
  }
}

// Екран Stateless: увесь стан зберігається в CornersModel
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 60),
            RoundedBoxSection(),
            SizedBox(height: 60),
            SlidersSection(),
          ],
        ),
      ),
    );
  }
}