import 'package:flutter/material.dart';
import 'package:movie_night/application/utils/string_extension.dart';

import '../../../constants/app_dimensions.dart';
import '../../../domain/api_client/image_downloader.dart';
import '../../../domain/api_client/media_type.dart';
import '../../../domain/entities/actor/actor_details.dart';
import '../../../domain/entities/movie/movie_genres.dart';
import '../../../domain/entities/tv_shows/tv_show_genres.dart';
import '../../navigation/app_navigation.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../cached_network_image_widget.dart';
import '../inkwell_material_widget.dart';

class ExpansionTileCreditsData<T> {
  final String header;
  final List<T> credits;
  final String Function(DateTime? date) stringFromDate;

  ExpansionTileCreditsData({
    required this.header,
    required this.credits,
    required this.stringFromDate,
  });
}

class ExpansionTileCreditsWidget extends StatelessWidget {
  final ExpansionTileCreditsData data;
  const ExpansionTileCreditsWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: AppColors.colorMainText,
      collapsedBackgroundColor: AppColors.colorPrimary,
      backgroundColor: AppColors.colorPrimary,
      textColor: AppColors.colorMainText,
      iconColor: AppColors.colorMainText,
      collapsedIconColor: AppColors.colorMainText,
      childrenPadding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.mediumPadding),
      tilePadding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.mediumPadding),
      title: Text(
        data.header,
        style: AppTextStyle.header3.copyWith(color: AppColors.colorMainText),
      ),
      children: <Widget>[
        SizedBox(
          height: 400,
          child: ListView.separated(
            itemCount: data.credits.length,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.colorMainText,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final item = data.credits[index];
              final itemMediaType = item.mediaType as MediaType;
              final genreIds = item.genreIds as List<int>;
              final isMovie = itemMediaType == MediaType.movie;
              final route =
                  isMovie ? Screens.movieDetails : Screens.tvShowDetails;
              final genreWidget = genreIds.map((genre) {
                if (isMovie) {
                  return MovieGenres.values
                      .firstWhere((element) => element.asId() == genre);
                } else {
                  return TvShowGenres.values
                      .firstWhere((element) => element.asId() == genre);
                }
              }).map((genre) {
                final genreName = genre is MovieGenres
                    ? genre.asString(context).capitalize()
                    : genre is TvShowGenres
                        ? genre.asString(context).capitalize()
                        : '';
                return Text(
                  genreName,
                  style: AppTextStyle.small.copyWith(
                    color: AppColors.colorSecondaryText,
                  ),
                );
              }).toList();
              return InkWellMaterialWidget(
                borderRadius: 0,
                color: AppColors.colorSplash,
                onTap: () => Navigator.of(context).pushNamed(
                  route,
                  arguments: item.id,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 152,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.radius5),
                              child: CachedNetworkImageWidget(
                                width: 80,
                                height: 124,
                                imageUrl: ImageDownloader.imageUrl(
                                  item.posterPath ?? '',
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              itemMediaType.asString(context),
                              style: AppTextStyle.header3.copyWith(
                                color: AppColors.colorMainText,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ListView(
                            children: [
                              Text(
                                item.title ?? '',
                                style: AppTextStyle.header3.copyWith(
                                  color: AppColors.colorMainText,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              if (item is Cast
                                  ? item.character != null &&
                                      item.character!.isNotEmpty
                                  : item is Crew
                                      ? item.job != null && item.job!.isNotEmpty
                                      : false)
                                Text(
                                  item is Cast
                                      ? item.character!
                                      : item is Crew
                                          ? item.job ?? ''
                                          : '',
                                  style: AppTextStyle.header3.copyWith(
                                    color: AppColors.colorSecondaryText,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              if (item.releaseDate != null)
                                Text(
                                  data.stringFromDate(item.releaseDate),
                                  style: AppTextStyle.medium.copyWith(
                                    color: AppColors.colorSecondaryText,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: genreWidget,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
