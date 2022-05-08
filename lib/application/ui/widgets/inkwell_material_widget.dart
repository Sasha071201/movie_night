import 'package:flutter/material.dart';

class InkWellMaterialWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final void Function()? onTap;
  const InkWellMaterialWidget({
    Key? key,
    required this.child,
    required this.color,
    required this.borderRadius,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(color),
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
