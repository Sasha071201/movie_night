import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/actor.dart';

import '../../../domain/entities/movie.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class ActorSuggestionItemWidget extends StatelessWidget {
  final Actor item;

  const ActorSuggestionItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.person,
          color: AppColors.colorSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          item.name,
          style: AppTextStyle.small.copyWith(
            color: AppColors.colorMainText,
          ),
        ),
      ],
    );
  }
}
