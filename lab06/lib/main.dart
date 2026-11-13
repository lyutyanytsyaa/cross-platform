import 'package:flutter/material.dart';
import './widgets/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFF3F0FA),

        // Поля вводу: білі, із заокругленими кутами
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: Colors.black38),
          prefixIconColor: Colors.deepPurple,
          border: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Color(0xFFDDD6EE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Color(0xFFDDD6EE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),

        // Кнопки: вищі та із заокругленими кутами
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: radius),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.deepPurple,
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
            side: const BorderSide(color: Colors.deepPurple),
            shape: RoundedRectangleBorder(borderRadius: radius),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
        ),
      ),
      home: const SignInScreen(),
    );
  }
}