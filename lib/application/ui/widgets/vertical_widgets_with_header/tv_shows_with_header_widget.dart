import 'package:flutter/material.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/entities/genre.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/widgets/vertical_widgets_with_header/vertical_tv_show_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/tv_shows/tv_show_genres.dart';
import '../../screens/main/main_view_model.dart';
import '../../screens/view_all_movies/view_all_movies_view_model.dart';
import '../../screens/view_favorite/view_favorite_view_model.dart';
import '../../screens/view_movies/view_movies_view_model.dart';
import 'vertical_widget_with_header.dart';

class TvShowWithHeaderData {
  final String title;
  final List<TvShow> list;
  final TvShowGenres? tvShowGenres;
  final int? tvShowId;
  final ViewMediaType? viewMediaType;
  final ViewFavoriteType? viewFavoriteType;

  TvShowWithHeaderData({
    required this.title,
    required this.list,
    this.tvShowGenres,
    this.tvShowId,
    this.viewMediaType,
    this.viewFavoriteType,
  });
}

class TvShowsWithHeaderWidget extends StatelessWidget {
  final TvShowWithHeaderData tvShowData;
  final void Function()? onPressed;

  const TvShowsWithHeaderWidget({
    Key? key,
    required this.tvShowData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalWidgetWithHeaderWidget(
        title: tvShowData.title,
        dataLength: tvShowData.list.length,
        itemBuilder: (index) => VerticalTvShowWidget(
              tvShow: tvShowData.list[index],
              onPressed: onPressed,
            ),
        onPressedViewAll: () async {
          try {
            context.read<MainViewModel>().showAdIfAvailable();
          } catch (e) {}
          if (tvShowData.tvShowGenres != null) {
            await Navigator.of(context)
                .pushNamed(Screens.viewAllMovies, arguments: [
              ViewAllMoviesData(
                  withGenres: [Genre(genre: tvShowData.tvShowGenres)]),
              MediaType.tv,
            ]);
            if (onPressed != null) onPressed!();
          } else if (tvShowData.viewMediaType != null &&
              tvShowData.tvShowId != null) {
            await Navigator.of(context).pushNamed(Screens.viewMovies,
                arguments: ViewMoviesData(
                  mediaType: MediaType.tv,
                  viewMoviesType: tvShowData.viewMediaType!,
                  mediaId: tvShowData.tvShowId!,
                ));
            if (onPressed != null) onPressed!();
          } else if (tvShowData.viewFavoriteType != null) {
            await Navigator.of(context).pushNamed(
              Screens.viewFavorite,
              arguments: ViewFavoriteData(
                mediaType: MediaType.tv,
                favoriteType: tvShowData.viewFavoriteType!,
              ),
            );
            if (onPressed != null) onPressed!();
          }
        });
  }
}
