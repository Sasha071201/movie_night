import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../resources/resources.dart';
import '../navigation/app_navigation.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';
import 'inkwell_material_widget.dart';

class VerticalActorWidget extends StatelessWidget {
  final void Function()? onPressed;

  const VerticalActorWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      onTap: () {
        if (onPressed != null) onPressed!();
        Navigator.of(context).pushNamed(Screens.actorDetails);
      },
      borderRadius: AppDimensions.radius5,
      color: AppColors.colorSplash,
      child: Column(
        children: [
          Container(
            height: 140,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.radius5,
              ),
            ),
            child: Image.asset(
              AppImages.personExample,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Daniel Stisen',
            style: AppTextStyle.subheader,
          ),
        ],
      ),
    );
  }
}
