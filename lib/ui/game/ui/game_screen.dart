import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final List<double> coeff = [0,1.1, 1.4, 2];
  int step = 1;
  int horizontal=1;
  @override
  initState() {
    var rng = Random();
    bombs = List.generate(3, (index) => rng.nextInt(3));
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
                          : 'You will get ${(widget.bet * coeff[step - 1]) + widget.bet * step-1}',
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
                              setState((){
                                step++;
                                horizontal=i;
                              });
                                if (bombs[2] != i && step == 3) {
                                print('win');
                                setState((){
                                  horizontal=i;
                                });
                              } else {
                                print(step);
                              }
                            },
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: i==horizontal&&step==3 ? Center(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Image.asset(Assets.images.player2.path,height: 70.h,)
                                  ],
                                ),
                              ) : null,
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
                              setState((){
                                step++;
                                horizontal=i;
                              });
                              if (bombs[1] != i && step == 2) {
                                setState((){
                                  print(i);
                                  horizontal=i;
                                });
                                  print('noBomb');
                              } else {
                                print(step);
                              }
                            },
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: i==horizontal&&step==2 ? Center(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Image.asset(Assets.images.player2.path,height: 70.h,)
                                  ],
                                ),
                              ) : null,
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
                              setState((){
                                if(step!=3) {
                                  step++;
                                  horizontal = i;
                                }
                              });
                              if (bombs[0] != i && step == 1) {
                                // setState(() => step++);
                                print('noBomb');
                              } else {
                                print(step);
                              }
                            },
                            child:  Container(
                              width: 109.w,
                              height: 93.h,
                              child: i==horizontal&&step==1 ? Center(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Image.asset(Assets.images.player2.path,height: 70.h,)
                                  ],
                                ),
                              ) : null,
                            ),
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
}
