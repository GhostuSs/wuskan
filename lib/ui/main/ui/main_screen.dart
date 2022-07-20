import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/game/ui/game_screen.dart';
import 'package:wuskan/ui/main/uikit/sum_container.dart';
import 'package:wuskan/uikit/main_button.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  int selectedSum = 250;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.darkBlue,
          floatingActionButton: MainButton(
              onTap: () => Navigator.push(
                    context,
                    PageTransition<Widget>(
                      child: GameScreen(
                        bet: selectedSum,
                      ),
                      type: PageTransitionType.rightToLeft,
                    ),
                  ),
              label: 'Start the game'),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
            minimum: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${Hive.box<UserModel>('user').values.first.balance!}',
                      style: AppTypography.main.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.w,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: Image.asset(
                        Assets.images.coin.path,
                        filterQuality: FilterQuality.high,
                        width: 27.w,
                        height: 27.h,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.h, bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Choose your bet',
                        style: AppTypography.main.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.w,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 343.w,
                        child: Text(
                          'If your amount is less than 1000, then the next day it will become 1000 again',
                          style: AppTypography.main.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.w,
                              color: AppColors.gray.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                ),
               Expanded(child:  ListView(
                 children: [
                   SumContainer(
                     isSelected: selectedSum == 10,
                     label: 'Training',
                     level: 1,
                     price: 10,
                     onPressed: () => setState(() {
                       selectedSum = 10;
                     }),
                   ),
                   SumContainer(
                     isSelected: selectedSum == 50,
                     label: 'Easy',
                     level: 2,
                     price: 50,
                     onPressed: () => setState(() {
                       selectedSum = 50;
                     }),
                   ),
                   SumContainer(
                     isSelected: selectedSum == 250,
                     label: 'Medium',
                     level: 3,
                     price: 250,
                     onPressed: () => setState(() {
                       selectedSum = 250;
                     }),
                   ),
                   SumContainer(
                     isSelected: selectedSum == 500,
                     label: 'Hard',
                     level: 4,
                     price: 500,
                     onPressed: () => setState(() {
                       selectedSum = 500;
                     }),
                   ),
                   SumContainer(
                     isSelected: selectedSum == 1000,
                     label: 'Insane',
                     level: 5,
                     price: 1000,
                     onPressed: () => setState(() {
                       selectedSum = 1000;
                     }),
                   ),
                   SizedBox(height: 90.h,),
                 ],
               ),)
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
