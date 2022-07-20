import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/main.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/onboarding/ui/onboarding.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<SettingsScreen> {
  int selectedSum = 250;
  InAppReview inappreview = InAppReview.instance;
  UserModel user = Hive.box<UserModel>('user').values.first;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.darkBlue,
          body: SafeArea(
            minimum: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.h,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      '${Hive.box<UserModel>('user').values.first.balance}',
                      style: AppTypography.main.copyWith(
                        fontSize:20.w,
                        fontWeight:FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
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
                  padding: EdgeInsets.only(top: 32.h,bottom: 8.h),
                  child: Text('Settings',style: AppTypography.main.copyWith(
                    fontSize: 28.w,
                    fontWeight: FontWeight.w500,

                  ),),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Text('Check what you need',style: AppTypography.main.copyWith(
                    fontSize: 16.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray.withOpacity(0.6)

                  ),),
                ),
                if(!subscribed)RawBtn(
                  label: 'Buy premium',
                  icon: Assets.images.premium,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OnBoardingScreen())),
                ),
                if(subscribed)RawBtn(
                    onTap: ()async {
                      if(Hive.box<UserModel>('user').values.first.lastUpdate!.day-DateTime.now().day>=1){
                        setState(()=> user.balance=user.balance!+user.dailyCoinBalance!);
                        await Hive.box<UserModel>('user').clear();
                        await Hive.box<UserModel>('user').add(user);
                      }else{
                        print('День еще не прошел');
                      }
                    },
                    label: 'Get daily coins',
                    icon: Assets.images.unlimcoins),
                RawBtn(
                    onTap: ()=>openPrivacyPolicy(),
                    label: 'Privacy policy',
                    icon: Assets.images.privacy),
                RawBtn(
                    onTap: ()=>openTermsOfUse(),
                    label: 'Terms of use',
                    icon: Assets.images.terms),
                RawBtn(
                    onTap:()=>inappreview.requestReview(),
                    label: 'Rate app',
                    icon: Assets.images.rate),
                RawBtn(
                    onTap:(){},
                    label: 'Share app',
                    icon: Assets.images.share),
                RawBtn(
                    onTap:()=>openSupport(),
                    label: 'Support',
                    icon: Assets.images.support),
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

class RawBtn extends StatelessWidget {
  RawBtn({this.onTap, required this.label, required this.icon});
  final String label;
  final VoidCallback? onTap;
  final  SvgGenImage icon;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
                color: Color(0xFF122855),
              border: Border.all(
                  color: label=='Buy premium' ? Color(0xFFFFE600) : AppColors.primaryBlue
             ,
                  width: 2.w
              )
            ),
            child: Row(
              children: [
                icon.svg(width: 20.w,
                color: label=='Buy premium' ? Color(0xFFFFE600) : AppColors.primaryBlue),
                SizedBox(width: 14.w,),
                Text(
                  label,
                  style: AppTypography.main.copyWith(
                      color:label == 'Buy premium'
                          ? Color(0xFFFFE600)
                          : AppColors.white,
                      fontSize: 20.w,
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
