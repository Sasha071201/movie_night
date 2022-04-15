import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:movie_night/application/utils/string_extension.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entities/movie/movie_genres.dart';
import '../../../domain/entities/search/multi_search.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class MovieSuggestionItemWidget extends StatelessWidget {
  final MultiSearchResult item;
  final DateFormat dateFormat;

  const MovieSuggestionItemWidget({
    Key? key,
    required this.item,
    required this.dateFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genres = item.genreIds!
        .map((genre) => MovieGenres.values
            .firstWhere((element) => element.asId() == genre)
            .asString(context)
            .capitalize())
        .join(',');
    final date = item.releaseDate != null ? dateFormat.format(item.releaseDate!) : '';
    return Row(
      children: [
        const Icon(
          Icons.movie,
          color: AppColors.colorSecondary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title!,
                style: AppTextStyle.small.copyWith(
                  color: AppColors.colorMainText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${S.of(context).movie}: $genres $date',
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
