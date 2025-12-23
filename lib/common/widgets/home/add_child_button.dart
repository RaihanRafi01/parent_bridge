import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddChildButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddChildButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: const Color(0xFFCC94EF), width: 1.5),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/profile/child.svg",
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Color(0xFF747688),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "Add child's more",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/profile/plus.svg",
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF7F56D9),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
