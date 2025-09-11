import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'document_dialog.dart';

class document_card extends StatelessWidget {
  const document_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9F1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Orange vertical bar on the left
          Container(
            width: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFF9A825),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title and download button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          'Parenting Plan Agreement',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.dialog(Document_dialog());
                        },
                        icon: const Icon(
                          Icons.download,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Legal tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9A825).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Legal',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF9A825),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // People
                  const Row(
                    children: [
                      Icon(Icons.person, size: 16, color: Color(0xFF999999)),
                      SizedBox(width: 4),
                      Text(
                        'Michael',
                        style: TextStyle(color: Color(0xFF666666)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(
                        Icons.people_alt,
                        size: 16,
                        color: Color(0xFF999999),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Emma Smithc',
                        style: TextStyle(color: Color(0xFF666666)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Upload date and file type
                  const Row(
                    children: [
                      Text(
                        'Uploaded • 2024-12-10',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'File Type • PDF',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
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
