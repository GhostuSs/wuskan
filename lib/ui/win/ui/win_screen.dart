import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/home/ui/home_screen.dart';
import 'package:wuskan/ui/main/ui/main_screen.dart';
import 'package:wuskan/uikit/main_button.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

class WinScreen extends StatefulWidget {
  final int sum;
  const WinScreen({Key? key, required this.sum}) : super(key: key);
  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  UserModel user = Hive.box<UserModel>('user').values.first;
  @override
  initState() {
    user.balance = user.balance! + widget.sum;
    Hive.box<UserModel>('user')
        .clear()
        .then((value) => Hive.box<UserModel>('user').add(user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: SafeArea(
          minimum: EdgeInsets.only(top: 60.h,bottom: 16.h,left: 16.w,right: 16.w,),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => HomeScreen())),
                    child: Icon(
                      Icons.clear,
                      size: 24.w,
                      color: AppColors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${user.balance!}',
                    style: AppTypography.main.copyWith(
                      fontSize: 20.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  Image.asset(Assets.images.coin.path,filterQuality: FilterQuality.high,width: 27.w,height: 27.h,)
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    'You win: + ${widget.sum}',
                    style: AppTypography.main.copyWith(
                      fontSize: 20.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  Image.asset(Assets.images.coin.path,filterQuality: FilterQuality.high,width: 27.w,height: 27.h,)
                ],
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  Assets.images.win.path,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  width: 345.w,
                  height: 345.h,
                ),
              ),
              Spacer(),
              MainButton(onTap: ()=>Navigator.push(context, PageTransition<Widget>(child: HomeScreen(),type:PageTransitionType.rightToLeft)), label: 'Go to Main Screen')
            ],
          ),
        ),
      ),
        onWillPop: () async => false,
    );
  }
}
