import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  extensions: [
    ShimmerTheme(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
    ),
  ],
  
  // Background color for the whole app
  scaffoldBackgroundColor: const Color(0xFF0F172A), // Deep Slate
  cardColor: const Color(0xFF1E293B), // Dark Container
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF1E293B),
    primary: Color(0xFF3B82F6),
  ),
  fontFamily: "PlusJakartaSans",

  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF0F172A),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.bold,
      fontFamily: 'PlusJakartaSans',
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(AppSizes.h48),
      backgroundColor: const Color(0xFF3B82F6), // A vibrant blue for dark mode buttons
      foregroundColor: const Color(0xFFFFFCFC),
      textStyle: TextStyle(
        fontSize: AppSizes.sp16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
    ),
  ),

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: AppSizes.sp20,
      fontFamily: "PlusJakartaSans",
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      decoration: TextDecoration.none,
      color: Colors.white,
      fontSize: AppSizes.sp16,
      fontFamily: "PlusJakartaSans",
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    displaySmall: TextStyle(
      fontFamily: "PlusJakartaSans",
      color: const Color(0xFFCBD5E1), // Light Slate
      fontSize: AppSizes.sp12,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: const Color(0xFFE2E8F0),
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
      color: const Color(0xFF94A3B8),
    ),

    titleSmall: TextStyle(
      color: const Color(0xFFCBD5E1),
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
      color: const Color(0xFFF1F5F9),
    ),

    bodyLarge: TextStyle(
      color: const Color(0xFFF8FAFC),
      fontSize: AppSizes.sp32,
      fontWeight: FontWeight.w800,
      fontFamily: "PlusJakartaSans",
      height: 0.875,
      letterSpacing: -0.5,
    ),
    bodyMedium: TextStyle(
      color: const Color(0xFFCBD5E1),
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w700,
      fontFamily: "PlusJakartaSans",
    ),
    bodySmall: TextStyle(
      color: const Color(0xFF64748B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w500,
      fontFamily: "PlusJakartaSans",
    ),
  ),
  
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide(color: const Color(0xFF475569), width: AppSizes.w1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide(color: const Color(0xFF3B82F6), width: AppSizes.w1), // Blue focus
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide(color: Colors.redAccent, width: AppSizes.w1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
      borderSide: BorderSide.none,
    ),
    errorMaxLines: 2,
    errorStyle: TextStyle(fontSize: AppSizes.sp15, height: 0.8),
    filled: true,
    fillColor: const Color(0xFF1E293B), // Dark input background
    prefixIconColor: const Color(0xFF64748B),
    suffixIconColor: const Color(0xFF64748B),

    labelStyle: TextStyle(
      color: Colors.white,
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w600,
      fontFamily: "PlusJakartaSans",
    ),
    hintStyle: TextStyle(
      color: const Color(0xFF64748B),
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

  dividerTheme: const DividerThemeData(color: Color(0xFF334155), thickness: 1),

  popupMenuTheme: PopupMenuThemeData(
    color: const Color(0xFF1E293B),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r15),
    ),
    shadowColor: Colors.black54,
    elevation: AppSizes.r2,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Colors.white,
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
