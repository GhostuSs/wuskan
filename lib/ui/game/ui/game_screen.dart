import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/main/ui/main_screen.dart';
import 'package:wuskan/ui/loose/ui/loose_screen.dart';
import 'package:wuskan/ui/win/ui/win_screen.dart';
import 'package:wuskan/uikit/main_button.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

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
  late double winsum;
  int horizontal = 1;
  UserModel user = Hive.box<UserModel>('user').values.first;
  @override
  initState() {
    var rng = Random();
    bombs = List.generate(4, (index) => rng.nextInt(3));
    bombs[0] = -100;
    winsum = widget.bet.toDouble();
    print(bombs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: Container(
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
                          onPressed: () => showCupertinoDialog(
                              context: context,
                              builder: (_) =>
                                  CupertinoAlertDialog(
                                    content: Text(
                                        'You will loose the money spent on the game'),
                                    title:
                                    Text('Exit the game?'),
                                    actions: [
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        onPressed: () =>
                                            Navigator.pop(
                                                context),
                                        child: Text(
                                          'Cancel',
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          user.balance =
                                          (user.balance! -
                                              widget.bet);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      MainScreen()));
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  )),
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.white,
                            size: 24.w,
                          )),
                      Spacer(),
                      Text(
                        '${user.balance}',
                        style: AppTypography.main.copyWith(
                          fontSize: 20.w,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(width: 4.w,),
                      Image.asset(
                        Assets.images.coin.path,
                        filterQuality: FilterQuality.high,
                        width: 27.w,
                        height: 27.h,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      step == 1
                          ? 'Choose the side and tap'
                          : 'You will get: +${winsum.round()}',
                      style: AppTypography.main.copyWith(
                        fontSize: 20.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w,),
                    if (winsum > widget.bet)
                      Image.asset(
                        Assets.images.coin.path,
                        width: 27.w,
                        filterQuality: FilterQuality.high,
                      )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () async {
                              if (Hive.box<UserModel>('user')
                                      .values
                                      .first
                                      .balance! >=
                                  widget.bet) {
                                if (step < 4)
                                  setState(() {
                                    step++;
                                    horizontal = i;
                                  });
                                if (bombs[3] != i && step == 4) {
                                  user.balance = user.balance! - widget.bet;
                                  setState(() =>
                                      winsum = winsum * coeff[3] + widget.bet);
                                  await Hive.box<UserModel>('user').clear();
                                  await Hive.box<UserModel>('user').add(user);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              WinScreen(sum: winsum.toInt())));
                                } else {
                                  await Hive.box<UserModel>('user').clear();
                                  await Hive.box<UserModel>('user').add(user);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LooseScreen(
                                              sum: winsum.toInt())));
                                }
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
                    Assets.images.gameborder.svg(width: 328.w),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () async {
                              if (Hive.box<UserModel>('user')
                                      .values
                                      .first
                                      .balance! >=
                                  widget.bet) {
                                if (step < 3)
                                  setState(() {
                                    step++;
                                    horizontal = i;
                                    horStepHistory[2] = i;
                                  });
                                if (bombs[2] != i && step == 3) {
                                  user.balance = user.balance! - widget.bet;
                                  setState(() =>
                                      winsum = winsum * coeff[2] + widget.bet);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LooseScreen(
                                                sum: winsum.toInt(),
                                              )));
                                }
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
                    Assets.images.gameborder.svg(width: 328.w),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () async {
                              if (Hive.box<UserModel>('user')
                                      .values
                                      .first
                                      .balance! >=
                                  widget.bet) {
                                if (step < 2)
                                  setState(() {
                                    step++;
                                    horizontal = i;
                                    horStepHistory[1] = i;
                                  });
                                if (bombs[1] != i && step == 2) {
                                  user.balance = user.balance! - widget.bet;
                                  setState(() => winsum *= coeff[1]);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LooseScreen(
                                                sum: winsum.toInt(),
                                              )));
                                }
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
                    Assets.images.gameborder.svg(width: 328.w),
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
                    Assets.images.gameborder.svg(width: 328.w),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tap cost - ${widget.bet} ',
                        style: AppTypography.main.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.w,
                        )),
                    Image.asset(
                      Assets.images.coin.path,
                      filterQuality: FilterQuality.high,
                      width: 27.w,
                      height: 27.h,
                    )
                  ],
                ),
                SizedBox(height: 26.h,),
                step > 1
                    ? MainButton(onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            WinScreen(sum: winsum.toInt()))), label: 'Take a reward')
                    : Container()
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false);
  Widget? cellIcon(int indexCell, int stepInd) {
    if ((stepInd < step && indexCell == bombs[stepInd - 1]))
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 54.h,
          width: 72.w,
        ),
      );
    if ((step == stepInd &&
        bombs[stepInd - 1] == indexCell &&
        bombs[stepInd - 1] != -100 &&
        stepInd > 1))
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 54.h,
          width: 72.w,
        ),
      );
    if ((step == 4 &&
            bombs[3] != indexCell &&
            indexCell != horizontal &&
            stepInd > 3) ||
        (horStepHistory[stepInd - 1] == indexCell && step > stepInd))
      return Center(
        child: Image.asset(
          'assets/images/greystar.png',
          filterQuality: FilterQuality.high,
          width: 72.w,
          height: 72.h,
        ),
      );
    if (step < 4 && stepInd - 1 == step)
      return Center(
        child: Container(
          child: Image.asset(
            'assets/images/yellowstar.png',
            filterQuality: FilterQuality.high,
            width: 72.w,
            height: 72.h,
          ),
        ),
      );

    ///Если попадаю на бомбу, то прощай - тут условия что я не попал
    if (step == 4 &&
        horizontal != bombs[3] &&
        stepInd == 4 &&
        indexCell == bombs[3])
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 54.h,
          width: 72.w,
        ),
      );
    if ((stepInd == 1 && indexCell == 1 && step > 1) ||
        (step > stepInd &&
            bombs[stepInd - 1] != indexCell &&
            bombs[stepInd - 1] != indexCell &&
            bombs[stepInd - 1] != -100 &&
            stepInd > 1) ||
        (horizontal != indexCell && step == stepInd && stepInd != 1))
      return Center(
        child: Image.asset(
          'assets/images/whitestar.png',
          filterQuality: FilterQuality.high,
          width: 72.w,
          height: 72.h,
        ),
      );
    return indexCell == horizontal && step == stepInd
        ? Center(
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  'assets/images/${user.activeSkin}.png',
                  height: 70.h,
                )
              ],
            ),
          )
        : null;
  }
}
