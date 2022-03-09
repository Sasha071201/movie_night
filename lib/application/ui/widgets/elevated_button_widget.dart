import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../themes/app_colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const ElevatedButtonWidget({
    Key? key,
    this.borderRadius,
    this.width,
    this.height = 50.0,
    this.gradient,
    this.backgroundColor = AppColors.colorPrimary,
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
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Center(child: child),
      ),
    );
  }
}
