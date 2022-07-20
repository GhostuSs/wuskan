import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const MainButton({Key? key, required this.onTap, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(120.r),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120.r),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF5894F2),
                  Color(0xFF11529E)
                ]
            )
        ),
        child: Container(
          height: 64.h,
          width: 343.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120.r),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1D98DE),
                    Color(0xFF005EBE),
                  ]
              )
          ),
          child: Center(
            child: Text(
              label,
              style: AppTypography.main.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.w,
                  letterSpacing: 0.76
              ),
            ),
          ),
        ),
      ),
    );
  }
}
