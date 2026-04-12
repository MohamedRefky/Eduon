import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  // useMaterial3: true,
  // brightness: Brightness.dark,
  // scaffoldBackgroundColor: Color(0xFF181818),
  // appBarTheme: AppBarTheme(
  //   backgroundColor: Color(0xFF181818),
  //   centerTitle: true,
  //   titleTextStyle: TextStyle(
  //     color: Color(0xFFFFFCFC),
  //     fontSize: AppSizes.sp20,
  //   ),
  //   iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
  // ),
  // colorScheme: ColorScheme.dark(
  //   primaryContainer: Color(0xFF282828),
  //   secondary: Color(0xFFC6C6C6),
  // ),
  // checkboxTheme: CheckboxThemeData(
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //   side: BorderSide(color: Color(0xFF6E6E6E), width: AppSizes.w2),
  // ),
  // switchTheme: SwitchThemeData(
  //   trackColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Color(0xFF15B86C);
  //     }
  //     return Colors.white;
  //   }),
  //   thumbColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.white;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.transparent;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return 0;
  //     }
  //     return 2;
  //   }),
  // ),
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     foregroundColor: Color(0xFFFFFCFC),
  //   ),
  // ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     minimumSize: Size.fromHeight(AppSizes.h40),
  //     backgroundColor: Color(0xFF15B86C),
  //     foregroundColor: Color(0xFFFFFCFC),
  //     textStyle: TextStyle(
  //       fontSize: AppSizes.sp16,
  //       fontWeight: FontWeight.w500,
  //     ),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(AppSizes.r30),
  //     ),
  //   ),
  // ),
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
  // textTheme: TextTheme(
  //   displayLarge: TextStyle(
  //     color: Color(0xFFFFFCFC),
  //     fontWeight: FontWeight.w400,
  //     fontSize: AppSizes.sp32,
  //   ),
  //   displayMedium: TextStyle(
  //     color: Color(0xFFFFFFFF),
  //     fontSize: AppSizes.sp28,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   displaySmall: TextStyle(
  //     color: Color(0xFFFFFFFF),
  //     fontSize: AppSizes.sp24,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   labelMedium: TextStyle(color: Colors.white, fontSize: AppSizes.sp16),
  //   labelLarge: TextStyle(color: Colors.white, fontSize: AppSizes.sp24),
  //   labelSmall: TextStyle(
  //     color: Color(0xFFFFFCFC),
  //     fontSize: AppSizes.sp20,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   titleSmall: TextStyle(
  //     color: Color(0xFFC6C6C6),
  //     fontSize: AppSizes.sp14,
  //     overflow: TextOverflow.ellipsis,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   titleMedium: TextStyle(
  //     color: Color(0xFFFFFCFC),
  //     fontSize: AppSizes.sp16,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   titleLarge: TextStyle(
  //     color: Color(0xFFA0A0A0),
  //     fontSize: AppSizes.sp16,
  //     decorationColor: Color(0xFFA0A0A0),
  //     decoration: TextDecoration.lineThrough,
  //     overflow: TextOverflow.ellipsis,
  //     fontWeight: FontWeight.w400,
  //   ),
  // ),
  // inputDecorationTheme: InputDecorationTheme(
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(AppSizes.r16),
  //     borderSide: BorderSide.none,
  //   ),
  //   errorBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(AppSizes.r16),
  //     borderSide: BorderSide(color: Colors.red, width: .75),
  //   ),
  //   filled: true,
  //   fillColor: Color(0xFF282828),
  //   hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
  // ),
  // iconTheme: IconThemeData(color: Color(0xFFFFFCFC), size: AppSizes.sp24),
  // dividerTheme: DividerThemeData(color: Color(0xFFC6C6C6), thickness: 1),
  // listTileTheme: ListTileThemeData(
  //   titleTextStyle: TextStyle(
  //     fontSize: AppSizes.sp16,
  //     color: Color(0xFFFFFCFC),
  //     fontWeight: FontWeight.w400,
  //   ),
  // ),
  // textSelectionTheme: TextSelectionThemeData(
  //   cursorColor: Colors.white,
  //   selectionColor: Colors.black,
  //   selectionHandleColor: Colors.white,
  // ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   backgroundColor: Color(0xFF181818),
  //   selectedItemColor: Color(0xFF15B86C),
  //   unselectedItemColor: Color(0xFFC6C6C6),
  //   type: BottomNavigationBarType.fixed,
  // ),
  // splashFactory: NoSplash.splashFactory,
  // popupMenuTheme: PopupMenuThemeData(
  //   color: Color(0xFF181818),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(16),
  //     side: BorderSide(color: Color(0xFF15B86C), width: AppSizes.w1),
  //   ),
  //   shadowColor: Color(0xFF15B86C),
  //   elevation: AppSizes.r2,
  //   labelTextStyle: WidgetStateProperty.all(
  //     TextStyle(
  //       color: Colors.white,
  //       fontSize: AppSizes.sp20,
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  // ),
);
