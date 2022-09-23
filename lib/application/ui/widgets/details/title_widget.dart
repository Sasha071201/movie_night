import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      title,
      style: AppTextStyle.header2.copyWith(
        color: AppColors.colorSecondary,
      ),
    );
  }
}
