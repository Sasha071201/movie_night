import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class TabCategoryItemWidget extends StatelessWidget {
  final int index;
  final int currentIndex;
  final void Function(int, BuildContext) selectCategory;
  final List<String> items;
  const TabCategoryItemWidget({
    Key? key,
    required this.index,
    required this.currentIndex,
    required this.selectCategory,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: GestureDetector(
        onTap: () => selectCategory(index, context),
        child: Center(
          child: Text(
            items[index],
            style: AppTextStyle.small.copyWith(
              color: currentIndex == index
                  ? AppColors.colorSecondary
                  : AppColors.colorMainText,
            ),
          ),
        ),
      ),
    );
  }
}
