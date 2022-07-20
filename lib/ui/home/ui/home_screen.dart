import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wuskan/ui/main/ui/main_screen.dart';
import 'package:wuskan/ui/settings/settings_screen.dart';
import 'package:wuskan/ui/skins/skins_screen.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/typography/apptypography.dart';

import '../../../gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: [
        MainScreen(),
        SkinsScreen(),
        SettingsScreen()
      ][_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: BottomNavigationBar(
          backgroundColor: AppColors.darkBlue,
          selectedLabelStyle: AppTypography.main.copyWith(
            fontSize:12.w
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Assets.images.gamepad.svg(width: 22.w,color: _selectedIndex==0 ? AppColors.primaryBlue : AppColors.gray.withOpacity(0.6)),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: Assets.images.skins.svg(width: 20.w,color: _selectedIndex==1 ? AppColors.primaryBlue : AppColors.gray.withOpacity(0.6)),
              label: 'Skins',
            ),
            BottomNavigationBarItem(
              icon: Assets.images.settings.svg(width: 20.w,color: _selectedIndex==2 ? AppColors.primaryBlue : AppColors.gray.withOpacity(0.6)),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primaryBlue,
          unselectedLabelStyle: AppTypography.main.copyWith(
            fontSize: 12.w,
            color: AppColors.darkBlue
          ),
          unselectedItemColor: AppColors.gray.withOpacity(0.6),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


}
