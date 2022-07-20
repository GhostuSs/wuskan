import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wuskan/ui/game/ui/game_screen.dart';
import 'package:wuskan/utils/color_palette/colors.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/typography/apptypography.dart';

class SumContainer extends StatelessWidget {
  final bool isSelected;
  final String label;
  final int level;
  final int price;
  final VoidCallback onPressed;
  const SumContainer({Key? key, required this.label, required this.level, required this.price, required this.onPressed, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16.5.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.5.r),
            color: isSelected ? AppColors.primaryBlue : Color(0xFF122855),
          ),
          child: Container(
            height: 96.h,
            padding: EdgeInsets.only(top: 26.h,bottom: 10.h,left: 14.w,right: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Color(0xFF122855)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for(int i=0;i<level;i++)Container(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Container(width: 18.w,height: 8.h,decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(120.r)
                      ),),
                    ),
                    for(int i=0;i<5-level;i++)Container(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Container(width: 18.w,height: 8.h,decoration: BoxDecoration(
                          color: AppColors.gray.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(120.r)
                      ),),
                    ),
                    Spacer(),
                    Text(price.toString(),
                      style: AppTypography.main.copyWith(
                          fontSize: 20.w,
                          fontWeight: FontWeight.w500
                      ),),
                    SizedBox(width: 4.w,),
                    Image.asset(Assets.images.coin.path,width: 27.w,height: 27.h,)
                  ],
                ),
                Spacer(),
                Text(label,style: AppTypography.main.copyWith(
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
