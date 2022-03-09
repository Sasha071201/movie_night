import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class TextButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  const TextButtonWidget({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.all(AppColors.colorSecondary),
      ),
    );
  }
}
