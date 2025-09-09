import 'package:flutter/material.dart';

class SpeedButton extends StatelessWidget {
  final double speed;
  final bool isSelected;
  final VoidCallback onTap;

  const SpeedButton({
    super.key,
    required this.speed,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20,
        width: 28,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: isSelected
              ? const LinearGradient(
            colors: [Color(0xFF2FCEF1), Color(0xFF7222EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isSelected ? null : Colors.transparent,
        ),
        child: Center(
          child: Text(
            "${speed}x",
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
