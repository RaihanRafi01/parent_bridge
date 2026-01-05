import 'package:flutter/material.dart';

class CustomGradientProgressIndicator extends StatelessWidget {
  final double progress;
  final double height;
  final Gradient gradient;
  final Color backgroundColor;
  final double radius;

  const CustomGradientProgressIndicator({
    super.key,
    required this.progress,
    this.height = 8.0,
    this.gradient = const LinearGradient(colors: [Colors.blue, Colors.purple]),
    this.backgroundColor = Colors.white,
    this.radius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
