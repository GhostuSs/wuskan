import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/utils/color_palette/colors.dart';

class GameScreen extends StatefulWidget {
  GameScreen({required this.bet});
  final int bet;
  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<GameScreen> {
  late final List<int> bombs;
  List<int> horStepHistory = List.generate(4, (index) => -1);
  final List<double> coeff = [0, 1.1, 1.4, 2];
  int step = 1;
  int horizontal = 1;
  @override
  initState() {
    var rng = Random();
    bombs = List.generate(4, (index) => rng.nextInt(3));
    bombs[0] = -100;
    print(bombs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
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
                  image: AssetImage('assets/images/bg1.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 45.h, top: 40.h, left: 16.w, right: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => print('menu'),
                          icon: Icon(
                            Icons.menu_rounded,
                            color: AppColors.white,
                            size: 30.w,
                          )),
                      Spacer(),
                      Text(
                        '1000',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28.w,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas'),
                      ),
                      Image.asset(
                        Assets.images.coin.path,
                        filterQuality: FilterQuality.high,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      step == 1
                          ? 'Choose the side and tap'
                          : 'You will get ${(widget.bet * coeff[step - 1]) + widget.bet * step - 1}',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.w,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas'),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () {
                              if (step < 4)
                                setState(() {
                                  step++;
                                  horizontal = i;
                                });
                              if (bombs[3] != i && step == 4) {
                                print('win');
                              } else {
                                print(step);
                              }
                            },
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: cellIcon(i, 4),
                            ),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () {
                              if (step < 3)
                                setState(() {
                                  step++;
                                  horizontal = i;
                                  horStepHistory[2]=i;
                                });
                              if (bombs[1] != i && step == 3) {
                                print('noBomb');
                              } else {
                                print(step);
                              }
                            },
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: cellIcon(i, 3),
                            ),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () {
                              if (step < 2)
                                setState(() {
                                  step++;
                                  horizontal = i;
                                  horStepHistory[1]=i;
                                });
                              if (bombs[1] != i && step == 2) {
                                print('noBomb');
                              } else {
                                print(step);
                              }
                            },
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: cellIcon(i, 2),
                            ),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Container(
                            width: 109.w,
                            height: 93.h,
                            child: cellIcon(i, 1),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false);
  Widget? cellIcon(int indexCell, int stepInd) {
    print(bombs);
    if ((step > stepInd &&
        bombs[stepInd-1] == indexCell &&
        bombs[stepInd-1] != -100 &&
        stepInd > 1))
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 72.h,
        ),
      );
    if((step==4&&bombs[3]!=indexCell&&indexCell!=horizontal&&stepInd>3)||(horStepHistory[stepInd-1]==indexCell&&step>stepInd))return Center(
      child: Assets.images.gamestar
          .svg(color: AppColors.white.withOpacity(0.5), width: 40.w, height: 40.h),
    );
    if(step<4&&stepInd-1==step)return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFC700).withOpacity(0.15),
              spreadRadius: 0.3,
              blurRadius: 7
            )
          ]
        ),
        child: Assets.images.gamestar
            .svg(color: Color(0xFFFFC700), width: 40.w, height: 40.h),
      ),
    );
    ///Если попадаю на бомбу, то прощай - тут условия что я не попал
    if(step==4&&horizontal!=bombs[3]&&stepInd==4&&indexCell==bombs[3])return Center(
      child: Image.asset(
        Assets.images.bomb.path,
        filterQuality: FilterQuality.high,
        height: 72.h,
      ),
    );
    if ((stepInd == 1 && indexCell == 1&&step>1) ||
        (step > stepInd &&
            bombs[stepInd-1] != indexCell &&
            bombs[stepInd-1] != -100 &&
            stepInd > 1))
      return Center(
        child: Assets.images.gamestar
            .svg(color: AppColors.white, width: 40.w, height: 40.h),
      );
    return indexCell == horizontal && step == stepInd
        ? Center(
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  Assets.images.player2.path,
                  height: 70.h,
                )
              ],
            ),
          )
        : null;
  }
}
