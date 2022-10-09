import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  AppTheme._();

  static final dark = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.colorPrimary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.colorBackground,
    canvasColor: AppColors.colorFFFFFF,
    iconTheme: const IconThemeData(color: AppColors.colorSecondary),
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: AppColors.colorFFFFFF),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        textStyle: MaterialStateProperty.all(AppTextStyle.buttonWithoutTheme),
        foregroundColor: MaterialStateProperty.all(AppColors.colorFFFFFF),
        backgroundColor: MaterialStateProperty.all(AppColors.colorPrimary),
        overlayColor: MaterialStateProperty.all(AppColors.colorSecondary),
        minimumSize: MaterialStateProperty.all(const Size(204, 50)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radius15),
          ),
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.colorFFFFFF,
      selectionColor: AppColors.colorSplash,
      selectionHandleColor: AppColors.colorMainText,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        size: 24,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24,
      ),
    ),
  );
}
