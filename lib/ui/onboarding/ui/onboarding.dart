import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/main.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/onboarding/uikit/info_container.dart';
import 'package:wuskan/uikit/main_button.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/routes/routes.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.darkBlue,
          body: SafeArea(
            minimum: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 21.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        final box = await Hive.openBox<bool>('seen');
                        await box.clear();
                        await box.put('seen', true);
                        Navigator.pushNamed(context, MainNavigationRoutes.main);
                      },
                      child: Icon(
                        Icons.clear,
                        color: AppColors.white,
                        size: 30.h,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 56.h),
                  child: Image.asset(
                    Assets.images.logo.path,
                    filterQuality: FilterQuality.high,
                    height: 285.h,
                    width: 374.w,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 54.h, bottom: 16.h),
                  child: Text.rich(TextSpan(
                      text: 'Buy ',
                      style: AppTypography.main.copyWith(
                          fontSize: 20.w,
                          fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                            text: "premium for 0.99\$ ".toUpperCase(),
                            style: AppTypography.main.copyWith(
                              fontSize: 20.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlue,
                            )),
                        TextSpan(
                          text: 'to unlock all the features',
                          style: AppTypography.main.copyWith(
                              fontSize: 20.w,
                              fontWeight: FontWeight.w500),
                        )
                      ])),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoContainer(label: 'Ads removing', image: Assets.images.speaker.svg(width: 22.w,height: 21.h),),
                    InfoContainer(label: 'Unlimited coins', image: Assets.images.unlimcoins.svg(width: 20.w,height: 21.h),),
                    InfoContainer(label: 'Santa Claus skin', image: Assets.images.palette.svg(width: 22.w,height: 21.h),),
                  ],
                ),
                Spacer(),
                MainButton(
                    onTap: () async {
                      purchase().then((value) => subscribed = value);
                      Navigator.pushNamed(context, MainNavigationRoutes.main);
                    },
                    label: 'Buy premium'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => openTermsOfUse(),
                        child: Text(
                          'Terms of use',
                          style: AppTypography.main.copyWith(
                              fontSize: 12.w, fontWeight: FontWeight.w400),
                        ),
                      ),
                      InkWell(
                        onTap: () => restore().then(
                            (value) => value ? Navigator.pop(context) : null),
                        child: Text(
                          'Restore',
                          style: AppTypography.main.copyWith(
                              fontSize: 12.w, fontWeight: FontWeight.w400),
                        ),
                      ),
                      InkWell(
                        onTap: () => openPrivacyPolicy(),
                        child: Text(
                          'Privacy Policy',
                          style: AppTypography.main.copyWith(
                              fontSize: 12.w, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
