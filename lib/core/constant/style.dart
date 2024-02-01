import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle style1 = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87);
TextStyle style2 = TextStyle(
    fontSize: 18.spMin, fontWeight: FontWeight.w600, color: Colors.black87);
TextStyle style3 = TextStyle(
    fontSize: 16.spMin, fontWeight: FontWeight.w600, color: Colors.black87);
TextStyle style4 = TextStyle(fontSize: 14.spMin, color: Colors.black87);

class Themes {
  static final light = ThemeData(
    //   appBarTheme: const AppBarTheme(backgroundColor: AppColor.lightbackgroundC),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.lightbackgroundC),
    drawerTheme:
        const DrawerThemeData(backgroundColor: AppColor.lightbackgroundC),
    textTheme: TextTheme(
      headlineLarge: style1,
      headlineSmall: style2,
      displayLarge: style2,
      displayMedium: style3,
      displaySmall: style4,
    ),
    brightness: Brightness.light,
    primaryColor: AppColor.lightbackgroundC,

    //colorScheme: ColorScheme(background: AppColor.lightbackgroundC, brightness: null),
  );
  static final dark = ThemeData(
    // appBarTheme: const AppBarTheme(backgroundColor: AppColor.darkbackgroundC),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.darkbackgroundC),
    drawerTheme:
        const DrawerThemeData(backgroundColor: AppColor.darkbackgroundC),
    textTheme: TextTheme(
      displayLarge:
          style2.copyWith(color: const Color.fromARGB(203, 255, 255, 255)),
      displayMedium:
          style3.copyWith(color: const Color.fromARGB(203, 255, 255, 255)),
      displaySmall:
          style4.copyWith(color: const Color.fromARGB(203, 255, 255, 255)),
      headlineLarge:
          style1.copyWith(color: const Color.fromARGB(203, 255, 255, 255)),
      headlineSmall:
          style2.copyWith(color: const Color.fromARGB(203, 255, 255, 255)),
    ),
    brightness: Brightness.dark,
    primaryColor: AppColor.darkbackgroundC,
    //colorScheme: ColorScheme(background: AppColor.darkbackgroundC),
  );
}
