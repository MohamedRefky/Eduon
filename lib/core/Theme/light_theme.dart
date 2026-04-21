import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFd2dae3),
  fontFamily: "PlusJakartaSans",

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFd2dae3),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xFF0F172A),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.bold,
      fontFamily: 'PlusJakartaSans',
    ),

    iconTheme: IconThemeData(color: Color(0xFF0F172A)),
  ),

  // colorScheme: ColorScheme.light(
  //   primaryContainer: Color(0xFFFFFFFF),
  //   secondary: Color(0xFF3A4640),
  // ),

  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(foregroundColor: Colors.black),
  // ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(AppSizes.h48),
      backgroundColor: Color(0xFF354155),
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(
        fontSize: AppSizes.sp16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
    ),
  ),

  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Color(0xFF15B86C),
  //   foregroundColor: Color(0xFFFFFCFC),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(AppSizes.r30),
  //   ),
  //   extendedTextStyle: TextStyle(
  //     fontSize: AppSizes.sp16,
  //     fontWeight: FontWeight.w500,
  //   ),
  // ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: AppSizes.sp20,
      fontFamily: "PlusJakartaSans",
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      decoration: TextDecoration.none,
      color: Colors.black,
      fontSize: AppSizes.sp16,
      fontFamily: "PlusJakartaSans",
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    displaySmall: TextStyle(
      fontFamily: "PlusJakartaSans",
      color: Color(0xFF334155),
      fontSize: AppSizes.sp12,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: Color(0xFFF2F5F8),
      fontSize: AppSizes.sp15,
      fontWeight: FontWeight.w500,
      fontFamily: "PlusJakartaSans",
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: AppSizes.sp20,
      fontFamily: "PlusJakartaSans",
      fontWeight: FontWeight.w700,
    ),
    labelSmall: TextStyle(
      fontSize: AppSizes.sp14,
      fontFamily: "PlusJakartaSans",
      fontWeight: FontWeight.bold,
      color: Color(0xFF475569),
    ),

    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: AppSizes.sp16,
      fontFamily: "PlusJakartaSans",
    ),

    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: AppSizes.sp22,
      fontWeight: FontWeight.w800,
      fontFamily: "PlusJakartaSans",
    ),

    titleLarge: TextStyle(
      fontSize: AppSizes.sp34,
      fontWeight: FontWeight.w800,
      fontFamily: "PlusJakartaSans",
      color: Color(0xFF363F57),
    ),

    bodyLarge: TextStyle(
      color: const Color(0xFF475569),
      fontSize: AppSizes.sp32,
      fontWeight: FontWeight.w800,
      fontFamily: "PlusJakartaSans",
      height: 0.875,
      letterSpacing: -0.5,
    ),
    bodyMedium: TextStyle(
      color: const Color(0xFF64748B),
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w700,
      fontFamily: "PlusJakartaSans",
    ),
    bodySmall: TextStyle(
      color: Color(0xFF94A3B8),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w500,
      fontFamily: "PlusJakartaSans",
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide(color: Color(0xFF94A3B8), width: AppSizes.w1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide(color: Color(0xFF94A3B8), width: AppSizes.w1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide(color: Colors.red, width: AppSizes.w1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide.none,
    ),
    errorMaxLines: 2,
    errorStyle: TextStyle(fontSize: AppSizes.sp15, height: 0.8),
    filled: true,
    fillColor: Color(0xFFF8FAFC),
    prefixIconColor: Color(0xFF94A3B8),
    suffixIconColor: Color(0xFF94A3B8),

    //isDense: true,
    // prefixIconConstraints: const BoxConstraints(),
    // suffixIconConstraints: const BoxConstraints(),
    hintStyle: TextStyle(
      color: Color(0xFF94A3B8),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w500,
      fontFamily: "PlusJakartaSans",
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  ),

  // iconTheme: IconThemeData(color: Color(0xFF161F1B), size: AppSizes.sp24),
  dividerTheme: DividerThemeData(color: Color(0xFF647C9E), thickness: 1),

  // listTileTheme: ListTileThemeData(
  //   titleTextStyle: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontSize: AppSizes.sp16,
  //     fontWeight: FontWeight.w400,
  //   ),
  // ),
  // textSelectionTheme: TextSelectionThemeData(
  //   cursorColor: Colors.black,
  //   selectionColor: Colors.white,
  //   selectionHandleColor: Colors.black,
  // ),

  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   backgroundColor: Color(0xFFF6F7F9),
  //   selectedItemColor: Color(0xFF14A662),
  //   unselectedItemColor: Color(0xFF3A4640),
  //   type: BottomNavigationBarType.fixed,
  // ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
    ),
    shadowColor: Color(0xFF3A4640),
    elevation: AppSizes.r2,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Colors.black,
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
