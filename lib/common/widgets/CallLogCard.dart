import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../appColors.dart';
import '../customFont.dart';


class CustomCallCard extends StatelessWidget {
  final String title;
  final String dateTime;
  final String duration;
  final Widget icon;
  final Color iconBackgroundColor;
  final Color cardBackgroundColor;
  final VoidCallback? onPlayRecording;

  const CustomCallCard({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.duration,
    required this.icon,
    required this.iconBackgroundColor,
    required this.cardBackgroundColor,
    this.onPlayRecording,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: h2.copyWith(
                    fontSize: 18,
                    color: AppColors.txtclr4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateTime,
                  style: h2.copyWith(
                    fontSize: 10,
                    color: AppColors.txtclr13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Duration: $duration',
                  style: h4.copyWith(
                    fontSize: 10,
                    color: AppColors.txtclr13,
                  ),
                ),
              ],
            ),
          ),
          if (onPlayRecording != null)
            SizedBox(
              height: 32,
              width: 122,
              child: ElevatedButton(
                onPressed: onPlayRecording,
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.blackactive,
                  backgroundColor: AppColors.yellow1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow, size: 23),
                    const SizedBox(width: 3),
                    Text(
                      'Play Recording',
                      style: h3.copyWith(
                        fontSize: 12,
                        color: AppColors.txtclr5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}