import 'package:flutter/material.dart';
import './widgets/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const SignInScreen(),
    );
  }
}

ThemeData _buildTheme() {
  const primary = Colors.pink;                // основний колір: рожевий
  const background = Color(0xFFFDF0F5);       // ніжно-рожевий фон
  const fieldBorder = Color(0xFFF3D3E0);      // рамка полів
  final radius = BorderRadius.circular(24);   // сильніше заокруглення

  return ThemeData(
    useMaterial3: false,

    fontFamily: 'serif',

    // Палітра кольорів
    colorScheme: ColorScheme.fromSeed(seedColor: primary),

    // Фон усіх екранів
    scaffoldBackgroundColor: background,

    // Стилі тексту
    textTheme: const TextTheme(
      // заголовки екранів: "Login", "Sign Up", "Reset Password"
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      // підписи над полями: "Email:", "Password:", "Name:"
      labelMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Вигляд кнопок
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.black38),
      prefixIconColor: primary,
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: fieldBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: fieldBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: primary, width: 2),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        side: const BorderSide(color: primary),
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
      ),
    ),
  );
}