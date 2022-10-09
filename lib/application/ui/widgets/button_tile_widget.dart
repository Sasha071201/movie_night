import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';

import 'inkwell_material_widget.dart';

class ButtonTileWidget extends StatelessWidget {
  const ButtonTileWidget({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      borderRadius: 0,
      color: AppColors.colorSplash,
      onTap: onPressed,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.colorPrimary,
        child: child,
      ),
    );
  }
}
