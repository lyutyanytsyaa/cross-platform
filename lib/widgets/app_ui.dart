import 'package:flutter/material.dart';

/// Пастельна бежева палітра застосунку
class AppColors {
  static const background = Color(0xFFF6EFE6);
  static const backgroundDark = Color(0xFFEBDCCB);
  static const card = Color(0xFFFFFBF6);
  static const field = Color(0xFFF4EADF);
  static const accent = Color(0xFFB98B65);
  static const accentLight = Color(0xFFE3C9AE);
  static const peach = Color(0xFFF2D9C4);
  static const text = Color(0xFF5A4636);
  static const textLight = Color(0xFF9C8573);
  static const success = Color(0xFF7FB77E);
  static const error = Color(0xFFD9776A);
}

/// Готові стилі тексту
class AppTextStyles {
  static const title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const subtitle = TextStyle(
    fontSize: 14,
    color: AppColors.textLight,
  );
}

const _logoUrl =
    'https://images.pexels.com/photos/12352496/pexels-photo-12352496.jpeg?auto=compress&cs=tinysrgb&w=300';

/// Фон з градієнтом, декоративними колами та карткою по центру
class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.background, AppColors.backgroundDark],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -70,
              right: -50,
              child: _buildCircle(200, AppColors.accentLight.withAlpha(120)),
            ),
            Positioned(
              bottom: -90,
              left: -60,
              child: _buildCircle(240, AppColors.peach.withAlpha(160)),
            ),
            Positioned(
              top: 140,
              left: -30,
              child: _buildCircle(80, AppColors.accentLight.withAlpha(80)),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withAlpha(45),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// Логотип у колі + заголовок + підзаголовок
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.field,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accentLight, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              _logoUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const FlutterLogo(size: 50),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.title,
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }
}

/// Поле вводу з підписом, іконкою та (для пароля) кнопкою "показати"
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _hidden,
          keyboardType: widget.keyboardType,
          style: const TextStyle(color: AppColors.text),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon, color: AppColors.accent),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _hidden
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textLight,
              ),
              onPressed: () => setState(() => _hidden = !_hidden),
            )
                : null,
          ),
        ),
      ],
    );
  }
}

/// Діалог з результатом: зелена галочка (успіх) або червоний знак (помилка)
Future<void> showResultDialog(
    BuildContext context, {
      required bool success,
      required String title,
      required String message,
    }) {
  final color = success ? AppColors.success : AppColors.error;

  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: color.withAlpha(40),
                shape: BoxShape.circle,
              ),
              child: Icon(
                success ? Icons.check_rounded : Icons.close_rounded,
                color: color,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: AppColors.textLight),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(bottom: 20, top: 8),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              minimumSize: const Size(160, 46),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}