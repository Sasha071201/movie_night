import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class MovieSuggestionItemWidget extends StatelessWidget {
  final Movie item;

  const MovieSuggestionItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.movie,
          color: AppColors.colorSecondary,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: AppTextStyle.small.copyWith(
                color: AppColors.colorMainText,
              ),
            ),
            Text(
              item.description,
              style: AppTextStyle.subheader2.copyWith(
                color: AppColors.colorSecondaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}