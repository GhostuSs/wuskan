import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/routes/routes.dart';


bool premium = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  Directory directory = Directory.current;
  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(directory.path);
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  // await boxs.clear();
  // await box.clear();
  // final boxf = await Hive.openBox<bool>('premium');
  // await boxf.clear();
  final s= await Hive.openBox<UserModel>('userdata');
  if(s.isEmpty)s.put('userdata', UserModel());
  final prem = await Hive.openBox<bool>('premium');
  if (prem.values.isEmpty) await prem.put('premium', false);
  premium = prem.values.first;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (Column) => MaterialApp(
        darkTheme: ThemeData(
          selectedRowColor: AppColors.aquaBlue,
          unselectedWidgetColor: AppColors.lightBlue.withOpacity(0.3),
        ),
        routes: routes,
        initialRoute: premium==true
            ? MainNavigationRoutes.main
            : MainNavigationRoutes.onboarding,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: AppColors.aquaBlue,
              selectedLabelStyle: TextStyle(
                fontFamily: 'MontBold',
                fontWeight: FontWeight.w400,
                fontSize: 12.h,
              ),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              unselectedItemColor:AppColors.aquaBlue.withOpacity(0.3),
              unselectedLabelStyle: TextStyle(
                  color: AppColors.aquaBlue.withOpacity(0.3),
                  fontFamily: 'MontBold',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              unselectedIconTheme: IconThemeData(color: AppColors.aquaBlue.withOpacity(0.3),)),
          textTheme: TextTheme(
              button: TextStyle(
                fontSize: 45.sp,
              )),
        ),
      ),
    );
  }
}