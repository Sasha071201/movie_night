import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../themes/app_colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? overlayColor;
  final Gradient? gradient;
  final bool enableBorder;
  final VoidCallback? onPressed;
  final Widget child;

  const ElevatedButtonWidget({
    Key? key,
    this.borderRadius,
    this.width,
    this.height = 50.0,
    this.backgroundColor = AppColors.colorPrimary,
    this.overlayColor,
    this.gradient,
    this.enableBorder = false,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.circular(AppDimensions.radius15);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom().copyWith(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          side: enableBorder
              ? MaterialStateProperty.all(
                  const BorderSide(
                    color: AppColors.colorSecondaryText,
                    width: 0.5,
                  ),
                )
              : null,
          shape: this.borderRadius != null
              ? MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: borderRadius),
                )
              : null,
          overlayColor: MaterialStateProperty.all(overlayColor),
        ),
        child: Center(child: child),
      ),
    );
  }
}
