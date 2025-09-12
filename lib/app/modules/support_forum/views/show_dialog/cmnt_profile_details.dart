import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class cmt_profile_details extends StatelessWidget {
  const cmt_profile_details({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          height: 34.h,
          width: 34.w,
          decoration: BoxDecoration( color: Colors.white,boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
              borderRadius: BorderRadius.circular(20)),
          child:    Center(
            child: Text(
              "AP",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 15),


        // Comment details
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Name
              Text(
                'Pronoy Sarkar',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 3),

              // Comment text
              Text(
                "I am a Flutter App Devoloper \ni am from Bangladesh ",
                style:   GoogleFonts.lato(

                  fontSize: 14,
                  color: Colors.black87,
                ),

              ),
              const SizedBox(height: 5),

              // Time + Reply
              Row(
                  children: [
                    Text(
                      "3h",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                        onTap: () {
                          // handle reply
                        },
                        child: const Text(
                            "Reply",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            )
                        )
                    )
                  ]
              )
            ]
        )
      ],


    );
  }
}