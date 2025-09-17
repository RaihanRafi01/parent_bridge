import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../appColors.dart';

class BuildDetailItem extends StatelessWidget {
  final Widget icon;
  final String value;
  final String label;
  final double? iconHeight;
  final double? iconWidth;
  final Color? iconColor;


  const BuildDetailItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconHeight,
    this.iconWidth,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 15,
          width: 15,
          child: iconColor != null
              ? IconTheme(
            data: IconThemeData(color: Color(0xFF1D3856)),
            child: icon,
          )
              : icon,
        ),
        const SizedBox(width: 12),
        Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.lato(
                color: AppColors.txtclr5,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.lato(
                color: Color(0xFF1D3856),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
