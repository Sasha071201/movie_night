import 'package:flutter/material.dart';

import 'package:movie_night/application/constants/app_dimensions.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../text_button_widget.dart';
import 'custom_dropdown_widget.dart';

class DropdownTextButtonWidget extends StatelessWidget {
  final String hint;
  final bool manageCurrentIndex;
  final int index;
  final List<String> items;
  final void Function(int currentIndex) onChanged;

  const DropdownTextButtonWidget({
    Key? key,
    required this.hint,
    this.manageCurrentIndex = false,
    this.index = -1,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWidget(
      builderButton: (currentIndex, toggleDropdown) => TextButtonWidget(
        child: Row(
          children: [
            ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
              child: Text(
                currentIndex != -1 ? items[currentIndex] : hint,
                style: AppTextStyle.button.copyWith(
                  color: currentIndex != -1
                      ? AppColors.colorSecondary
                      : AppColors.colorSecondaryText,
                    
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.colorSecondary,
            ),
          ],
        ),
        onPressed: toggleDropdown,
      ),
      builderDropdown: (currentIndex, onTap, scrollConfiguration) =>
          scrollConfiguration(
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => onTap(index),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 5,
                ),
                child: Text(
                  items[index],
                  style: AppTextStyle.subheader2.copyWith(
                    color: index == currentIndex
                        ? AppColors.colorSecondary
                        : AppColors.colorMainText,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      onChanged: (currentIndex) => onChanged(currentIndex),
      initialIndex: index,
      manageCurrentIndex: manageCurrentIndex,
      colorDropdown: AppColors.colorPrimary,
      borderRadiusDropdown: BorderRadius.circular(
        AppDimensions.radius5,
      ),
    );
  }
}
