import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/game/ui/game_screen.dart';
import 'package:wuskan/ui/settings/settings_screen.dart';
import 'package:wuskan/ui/webview/webview.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/routes/routes.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BackgroundScreenState();
  }
}

class Backgrounds{
  Backgrounds({this.name,this.price});
  String? name;
  int? price;
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  static List<Backgrounds> bgs = [
    Backgrounds(name: 'bg1',price: 0),
    Backgrounds(name: 'bg2',price: 5000),
  Backgrounds(name: 'bg3',price: 10000)
  ];

  int currInd = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFF142850),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF142850), Color(0xFF253B6E)]),
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${bgs[currInd].name}.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.only(bottom: 58.h, top: 56.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30.w,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${Hive.box<UserModel>('user').values.first.balance}',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28.h,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Image.asset(
                            Assets.images.coin.path,
                            filterQuality: FilterQuality.high,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 500.h,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (currInd > 0) setState(() => currInd--);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Container(
                                height: 350.h,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.white,
                                    size: 30.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 350.h,
                            child: Center(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (currInd >=0&&currInd<2) setState(() => currInd++);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: Container(
                                        height: 350.h,
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.white,
                                            size: 30.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Hive.box<UserModel>('user').values.first.availableBg!.contains(bgs[currInd].name) ? Container()
                      :Padding(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(bgs[currInd].price!.toString(),style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.w,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas'
                      ),),
                      Image.asset(Assets.images.coin.path,filterQuality: FilterQuality.high,)
                    ],
                  ),padding: EdgeInsets.only(bottom: 12.h),),
                  InkWell(
                    onTap: (){
                      final userData = Hive.box<UserModel>('user').values.first;
                      if(userData.availableBg!.contains(bgs[currInd])==false&&(userData.balance)!>=bgs[currInd].price!){
                        setState((){
                          userData.balance=userData.balance!-bgs[currInd].price!;
                          userData.availableBg!.add(bgs[currInd].name!);
                        });
                      }
                      if(userData.availableBg!.contains(bgs[currInd])==true&&userData.activeBg! != bgs[currInd]){
                        setState(()=>userData.activeBg=bgs[currInd].name!);
                      }
                    },
                    child: Container(
                      width: 279.w,
                      height: 72.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Svg(pathSelector(),size: Size(279.w,72.h))
                          )
                      ),
                      child: Center(
                        child: Text(labelSelector(),style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas',
                            fontSize: 35.w
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }

  String labelSelector(){
    if(Hive.box<UserModel>('user').values.first.activeBg==bgs[currInd].name!)return 'CHOSEN';
    if (Hive.box<UserModel>('user').values.first.availableBg!.contains(bgs[currInd]))return 'CHOOSE';
    return 'BUY';
  }
  String pathSelector(){
    if(Hive.box<UserModel>('user').values.first.activeBg==bgs[currInd].name!)return Assets.images.inactivebtngray.path;
    if (Hive.box<UserModel>('user').values.first.availableBg!.contains(bgs[currInd]))return Assets.images.onboardingbtn.path;
    return Assets.images.onboardingbtn.path;
  }
}
