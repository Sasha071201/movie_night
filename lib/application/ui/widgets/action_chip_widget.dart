import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../themes/app_colors.dart';
import 'inkwell_material_widget.dart';

class ActionChipWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final Color? backgroundColor;

  const ActionChipWidget({
    Key? key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      borderRadius: AppDimensions.radius15,
      color: AppColors.colorSplash,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(
            AppDimensions.radius15,
          ),
        ),
        child: child,
      ),
    );
  }
}
