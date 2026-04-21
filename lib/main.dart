import 'package:eduon/core/Theme/light_theme.dart';
import 'package:eduon/core/Theme/themes_controller.dart';
import 'package:eduon/core/service/auth_service.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/features/auth/screens/login_screen.dart';
import 'package:eduon/features/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/service/prefrances_maneger.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await PrefrancesManeger().init();
  ThemesController.init();
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: const MyApp(),
    ),
  );
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
              home: PrefrancesManeger().getOnboardingSeen()
                  ? LoginScreen()
                  : const OnboardingScreen(),
            );
          },
        );
      },
    );
  }
}
