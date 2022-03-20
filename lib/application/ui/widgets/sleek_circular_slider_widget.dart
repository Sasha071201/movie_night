import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';

class SleekCircularSliderWidget extends StatelessWidget {
  final void Function(double)? onChangeEnd;
  const SleekCircularSliderWidget({
    Key? key,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 10,
      initialValue: 8.3,
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(
          progressBarWidth: 6,
          shadowWidth: 0,
        ),
        customColors: CustomSliderColors(
          progressBarColor: AppColors.colorSecondary,
          dotColor: AppColors.colorPrimary,
          trackColor: AppColors.colorBackground,
        ),
        size: 100,
        startAngle: -90,
        angleRange: 270,
      ),
      onChangeEnd: onChangeEnd,
      innerWidget: (double value) => Center(
        child: Text(
          value.toStringAsFixed(1),
          style: AppTextStyle.medium,
        ),
      ),
    );
  }
}
