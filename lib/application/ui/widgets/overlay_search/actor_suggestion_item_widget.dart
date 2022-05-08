import 'package:flutter/material.dart';


import '../../../../generated/l10n.dart';
import '../../../domain/entities/search/multi_search.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class ActorSuggestionItemWidget extends StatelessWidget {
  final MultiSearchResult item;

  const ActorSuggestionItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gender = item.gender == 1 ? S.of(context).female : S.of(context).male;
    return Row(
      children: [
        const Icon(
          Icons.person,
          color: AppColors.colorSecondary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.small.copyWith(
                  color: AppColors.colorMainText,
                ),
              ),
              Text(
                "${S.of(context).person}: $gender",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.subheader2.copyWith(
                  color: AppColors.colorSecondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
