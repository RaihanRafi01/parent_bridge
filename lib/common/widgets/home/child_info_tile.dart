import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChildInfoTile extends StatelessWidget {
  final String index;
  final String name;
  final String age;

  const ChildInfoTile({
    super.key,
    required this.index,
    required this.name,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD), // হালকা নীল ব্যাকগ্রাউন্ড
        borderRadius: BorderRadius.circular(50.0), // সম্পূর্ণ গোলাকার বর্ডার
        border: Border.all(
          color: const Color(0xFFCC94EF).withAlpha(128),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Text(
            index,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4A4A),
            ),
          ),
          const SizedBox(width: 12),
          SvgPicture.asset(
            "assets/images/profile/child.svg",
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Color(0xFF6B6B6B),
              BlendMode.srcIn,
            ),
          ),

          const SizedBox(width: 8),
          Text(
            '$name : $age',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ],
      ),
    );
  }
}
