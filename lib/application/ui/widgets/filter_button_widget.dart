import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';

import '../navigation/app_navigation.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.filter_alt,
            color: AppColors.colorSecondary,
          ),
          Text(
            'Filter',
            style: AppTextStyle.button.copyWith(
              color: AppColors.colorSecondary,
            ),
          ),
        ],
      ),
      onPressed: () => Navigator.of(context).pushNamed(Screens.filterMovies),
    );
  }
}
