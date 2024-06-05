
import 'package:flutter/material.dart';
import 'package:flutter_application_1/teacher/custom/AppText.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.btnname,
    required this.click,
  });
  final String btnname;
  final void Function() click;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6).r, color: Colors.blueAccent),
        child: Center(
          child: AppText(
              text: btnname,
              color: Colors.white,
              size: 14,
              fontWeight: FontWeight.w600),

        ),
      ),
    );
  }
}