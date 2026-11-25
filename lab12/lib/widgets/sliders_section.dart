import 'package:flutter/material.dart';
import '../models/corners_model.dart';
import './corner_slider.dart';

/// Секція з чотирма slider'ами у сітці 2х2
class SlidersSection extends StatelessWidget {
  const SlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: CornerSlider(label: 'TL', corner: Corner.topLeft)),
            Expanded(child: CornerSlider(label: 'TR', corner: Corner.topRight)),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: CornerSlider(label: 'BL', corner: Corner.bottomLeft)),
            Expanded(
                child: CornerSlider(label: 'BR', corner: Corner.bottomRight)),
          ],
        ),
      ],
    );
  }
}