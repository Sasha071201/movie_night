import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:movie_night/application/domain/entities/tv_shows/tv_show_genres.dart';
import 'package:movie_night/application/utils/string_extension.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entities/search/multi_search.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class TvShowSuggestionItemWidget extends StatelessWidget {
  final MultiSearchResult item;
  final DateFormat dateFormat;

  const TvShowSuggestionItemWidget({
    Key? key,
    required this.item,
    required this.dateFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genres = item.genreIds!
        .map((genre) => TvShowGenres.values
            .firstWhere((element) => element.asId() == genre)
            .asString(context)
            .capitalize())
        .join(',');
    final date =
        item.firstAirDate != null ? dateFormat.format(item.firstAirDate!) : '';
    return Row(
      children: [
        const Icon(
          Icons.movie_filter,
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
                '${S.of(context).tv_show}: $genres $date',
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
