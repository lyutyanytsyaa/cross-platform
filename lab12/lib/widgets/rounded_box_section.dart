import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/corners_model.dart';

/// Секція з синім контейнером 150х150.
/// Слухає CornersModel і перемальовується, коли змінюється радіус.
class RoundedBoxSection extends StatelessWidget {
  const RoundedBoxSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CornersModel>(
      builder: (context, corners, child) {
        return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: corners.borderRadius,
          ),
        );
      },
    );
  }
}