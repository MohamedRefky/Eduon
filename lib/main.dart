import 'package:eduon/core/Theme/light_theme.dart';
import 'package:eduon/core/Theme/themes_controller.dart';
import 'package:eduon/features/auth/login.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/service/prefrances_maneger.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrancesManeger().init();
  ThemesController.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: ThemesController.themeNotifier,
          builder: (context, ThemeMode currentMode, child) {
            return MaterialApp(
              navigatorObservers: [routeObserver],
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              //darkTheme: darkTheme,
              themeMode: currentMode,
              home: const Login(),
            );
          },
        );
      },
    );
  }
}
