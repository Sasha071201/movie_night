import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_theme.dart';

import '../../constants/app_dimensions.dart';
import '../themes/app_text_style.dart';

class DialogWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? width;
  final double? height;
  static bool _isSnackbarActive = false;

  const DialogWidget._({
    Key? key,
    required this.child,
    required this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
      child: Dialog(
        elevation: 0,
        backgroundColor: AppColors.colorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.radius15,
          ),
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              top: 24.0,
              right: 24.0,
              bottom: 8.0,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  static Future show({
    required BuildContext context,
    required Widget child,
    double? width,
    double? height,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color(0xE515171F),
      builder: (_) => DialogWidget._(
        height: height,
        width: width,
        child: child,
        color: AppColors.colorPrimary,
      ),
    );
  }

  static Future<DateTime?> showDataPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: Locale(
        Localizations.localeOf(context).toLanguageTag(),
      ),
      builder: (context, child) {
        return Theme(
          data: AppTheme.dark.copyWith(
            dialogBackgroundColor: AppColors.colorBackground,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.colorSecondary,
              surface: AppColors.colorPrimary,
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String text,
    Duration duration = const Duration(milliseconds: 5000),
    Color backgroundColor = AppColors.colorPrimary,
  }) {
    if (!_isSnackbarActive) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(
                text,
                style: AppTextStyle.medium.copyWith(
                  color: AppColors.colorMainText,
                ),
              ),
              backgroundColor: backgroundColor,
              duration: duration,
            ),
          )
          .closed
          .then((value) {
        _isSnackbarActive = false;
      });
      _isSnackbarActive = true;
    }
  }

  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
