import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGradientProgressIndicator extends StatelessWidget {
  final double progress;
  final double height;
  final Gradient gradient;
  final Color backgroundColor;
  final double radius;

  const CustomGradientProgressIndicator({
    Key? key,
    required this.progress,
    this.height = 8.0,
    this.gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
    this.backgroundColor = Colors.white,
    this.radius = 10.0,
  }) : super(key: key);

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