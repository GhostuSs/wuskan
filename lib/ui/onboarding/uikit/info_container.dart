import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

class InfoContainer extends StatelessWidget {
  final String label;
  final Widget image;
  const InfoContainer({Key? key, required this.label, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.5.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5894F2),
              Color(0xFF11529E),
            ],
          )
      ),
      child: Container(
        height: 80.h,
        padding: EdgeInsets.only(top: 17.h,bottom: 12.h,left: 12.w,right: 12.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Color(0xFF122855)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            Spacer(),
            Text(label,style: AppTypography.main.copyWith(
              fontSize: 12.w,
              fontWeight: FontWeight.w400,
            ),)
          ],
        ),
      ),
    );
  }
}
