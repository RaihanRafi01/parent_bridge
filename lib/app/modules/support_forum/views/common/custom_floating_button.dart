import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custom_floating_button extends StatelessWidget {
  const Custom_floating_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 91.h,
        width: 91.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xff86D0F3), Color(0xffB260EB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(.5),
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          highlightElevation: 0,
          shape: CircleBorder(),
          onPressed: () {},
          child: const Icon(Icons.add, size: 21.49),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}