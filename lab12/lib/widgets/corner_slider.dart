import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/corners_model.dart';

/// Один slider для одного кута: підпис "TL: 56.02" + Slider
class CornerSlider extends StatelessWidget {
  const CornerSlider({super.key, required this.label, required this.corner});

  final String label;
  final Corner corner;

  @override
  Widget build(BuildContext context) {
    // watch — читаємо значення і підписуємось на зміни
    final value = context.watch<CornersModel>().radiusOf(corner);

    return Column(
      children: [
        Text.rich(
          TextSpan(
            text: '$label: ',
            children: [
              TextSpan(
                text: value.toStringAsFixed(2),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Slider(
          value: value,
          min: 0,
          max: CornersModel.maxRadius,
          // read — лише викликаємо метод, без підписки на зміни
          onChanged: (newValue) =>
              context.read<CornersModel>().setRadius(corner, newValue),
        ),
      ],
    );
  }
}