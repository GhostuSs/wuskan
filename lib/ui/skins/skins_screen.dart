import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/main.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/main/ui/main_screen.dart';
import 'package:wuskan/ui/onboarding/ui/onboarding.dart';
import 'package:wuskan/uikit/main_button.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

class SkinsScreen extends StatefulWidget {
  const SkinsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SkinsScreenState();
  }
}

class Skin {
  Skin({this.name, this.dispname, this.description, this.price,this.premOnly,});

  int? price;
  String? dispname;
  String? name;
  String? description;
  bool? premOnly;
}

class _SkinsScreenState extends State<SkinsScreen> {
  static List<Skin> skins = [
    Skin(name: 'standart', dispname: 'Standart', description: '', price: 0),
    Skin(
        name: 'masquerade',
        dispname: 'Masquerade',
        description: '',
        price: 2000),
    Skin(
        name: 'basketball',
        dispname: 'Basketball',
        description:
            'Cunning and clever thief, capable ofboth stealing a smal trinket and mining an entire building',
        price: 3500),
    Skin(
        name: 'santaclaus',
        dispname: 'Santa Claus',
        description: "",
        premOnly: true,
    ),
  ];
  UserModel user = Hive.box<UserModel>('user').values.first;
  int currInd = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.darkBlue,
          body: SafeArea(
            minimum: EdgeInsets.only(left: 16.w,right: 16.w,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      '${Hive.box<UserModel>('user').values.first.balance}',
                      style: AppTypography.main.copyWith(
                          fontSize: 20.w, fontWeight: FontWeight.w500),
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
                SizedBox(
                  height: 33.h,
                ),
                Container(
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/${skins[currInd].name}.png',
                                  filterQuality: FilterQuality.high,height: 342.h,),
                                Text(
                                  skins[currInd].dispname!,
                                  style: AppTypography.main.copyWith(
                                    fontSize: 28.w,
                                    fontWeight: FontWeight.w500,
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
                Row(
                  children: [
                    if(currInd!=0) RawSelBtn(label: 'Prev',onPressed: (){
                      if (currInd > 0) setState(() => currInd--);
                    },),
                    Spacer(),
                    if(currInd<3)RawSelBtn(label: 'Next', onPressed: (){
                      if (currInd < 4) setState(() => currInd++);
                    }),
                  ],
                ),
                Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(120.r),
                  onTap: () {
                    final userData = user;
                    if(skins[currInd].price!=null){
                      if (userData.availableSkins!
                          .contains(skins[currInd].name) ==
                          false &&
                          (userData.balance)! >= skins[currInd].price!) {
                        setState(() {
                          userData.balance =
                              userData.balance! - skins[currInd].price!;
                          userData.availableSkins!.add(skins[currInd].name!);
                        });
                      }
                    }else{
                      if(skins[currInd].premOnly==true&&subscribed==true){
                        userData.availableSkins!.add(skins[currInd].name!);
                      }else{
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>OnBoardingScreen()));
                      }
                    }
                    if (userData.availableSkins!
                        .contains(skins[currInd].name) ==
                        true &&
                        userData.activeSkin! != skins[currInd]) {
                      setState(
                              () => userData.activeSkin = skins[currInd].name);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120.r),
                        gradient: labelSelector()=='Chosen' ? LinearGradient(colors: [
                          AppColors.gray,
                          AppColors.gray,
                        ]) :LinearGradient(
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
                          gradient: labelSelector()=='Chosen' ? LinearGradient(colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.3),
                          ]) :LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF1D98DE),
                                Color(0xFF005EBE),
                              ]
                          )
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              labelSelector(),
                              style: AppTypography.main.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.w,
                                  letterSpacing: 0.76
                              ),
                            ),
                            labelSelector().contains('Buy for') ? Image.asset(Assets.images.coin.path,filterQuality: FilterQuality.high,width: 27.w,) : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }

  String labelSelector() {
    if (Hive.box<UserModel>('user').values.first.activeSkin ==
        skins[currInd].name) return 'Chosen';
    if (Hive.box<UserModel>('user')
        .values
        .first
        .availableSkins!
        .contains(skins[currInd].name!) || skins[currInd].premOnly==true&&subscribed==true) return 'Choose';
    if(skins[currInd].premOnly==true) return 'Premium only';
    return 'Buy for ${skins[currInd].price!} ';
  }

  String pathSelector() {
    if (Hive.box<UserModel>('user').values.first.activeSkin ==
        skins[currInd].name) return Assets.images.inactivebtngray.path;
    if (Hive.box<UserModel>('user')
        .values
        .first
        .availableSkins!
        .contains(skins[currInd].name!))
      return Assets.images.onboardingbtn.path;
    return Assets.images.onboardingbtn.path;
  }
}

class RawSelBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const RawSelBtn({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
        borderRadius: BorderRadius.circular(120.r),
        child:Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5894F2),
                Color(0xFF11529E)
              ]
            ),
            borderRadius: BorderRadius.circular(120.r)
          ),
          child: Container(
            width: 165.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
                borderRadius: BorderRadius.circular(120.r)
            ),
            child: Center(
                child: Text(
                  label,
                  style: AppTypography.main.copyWith(
                    fontSize: 20.w,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        ));
  }
}
