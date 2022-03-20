import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/elevated_button_widget.dart';
import 'package:movie_night/application/ui/widgets/icon_button_widget.dart';
import 'package:movie_night/application/ui/widgets/sleek_circular_slider_widget.dart';

import '../../constants/app_dimensions.dart';

class DialogWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? width;
  final double? height;

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
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2, tileMode: TileMode.decal),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButtonWidget(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.colorSecondary,
                  ),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
              ),
              child,
            ],
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
  }) {
    return showDialog(
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

  static void showDialogRateMovie(BuildContext context) {
    DialogWidget.show(
      context: context,
      width: 358, //not overflow and not changed
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SleekCircularSliderWidget(
              onChangeEnd: (value) {},
            ),
            const SizedBox(height: 16),
            ElevatedButtonWidget(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              width: 200,
              child: Text(
                'Rate',
                style: AppTextStyle.button,
              ),
              enableBorder: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
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
      locale: Locale(Localizations.localeOf(context).toLanguageTag()),
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required Widget content,
    Duration duration = const Duration(milliseconds: 1000),
    Color backgroundColor = AppColors.colorPrimary,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
