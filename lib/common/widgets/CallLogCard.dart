import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCallCard extends StatelessWidget {
  // কার্ডটি দেখানোর জন্য প্রয়োজনীয় সব ডেটা আমরা বাইরে থেকে নেব
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
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF474747)
                  )
                ),
                const SizedBox(height: 4),
                Text(
                  dateTime,
                  style:  GoogleFonts.lato(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF474747)
                  )
                ),
                const SizedBox(height: 2),
                Text(
                  'Duration: $duration',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          // ডান পাশের 'Play Recording' বাটন
          //SizedBox(width: 38,),
          // Only show button if onPlayRecording is not null
          if (onPlayRecording != null)
            SizedBox(
              height: 35,
              width: 130,
              child: ElevatedButton.icon(
                onPressed: onPlayRecording,
                icon: const Icon(Icons.play_arrow, size: 14),
                label: const Text(
                  'Play Recording',
                  style: TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ),
            ),

        ],
      ),
    );

  }
}