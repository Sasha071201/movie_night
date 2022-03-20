import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Widget icon;
  final void Function() onPressed;

  const IconButtonWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
