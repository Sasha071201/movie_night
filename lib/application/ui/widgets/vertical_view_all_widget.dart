import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';

import '../../constants/app_dimensions.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';

class VerticalViewAllWidget extends StatelessWidget {
  final double width;
  final double height;
  final void Function() onPressed;

  const VerticalViewAllWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      onTap: onPressed,
      borderRadius: AppDimensions.radius5,
      color: AppColors.colorSplash,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(AppDimensions.radius5),
        ),
        child: Center(
          child: Text(
            'View All',
            style: AppTextStyle.button,
          ),
        ),
      ),
    );
  }
}
