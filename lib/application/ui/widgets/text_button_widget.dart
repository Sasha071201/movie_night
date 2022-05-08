import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class TextButtonWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? overlayColor;
  final void Function() onPressed;
  const TextButtonWidget({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.overlayColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.all(
          overlayColor ?? AppColors.colorSplash,
        ),
      ),
    );
  }
}
