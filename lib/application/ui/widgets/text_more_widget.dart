import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';

class TextMoreWidget extends StatelessWidget {
  final String text;
  const TextMoreWidget(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Length,
      trimLength: 154,
      trimCollapsedText: 'more',
      trimExpandedText: 'less',
      delimiter: '   ',
      style: AppTextStyle.small.copyWith(
        color: AppColors.colorSecondaryText,
      ),
      lessStyle: AppTextStyle.buttonWithoutTheme.copyWith(
          color: AppColors.colorSecondary,
          ),
      moreStyle: AppTextStyle.buttonWithoutTheme.copyWith(
          color: AppColors.colorSecondary,
          ),
    );
  }
}
