import 'package:flutter/material.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/entities/movie/movie.dart';
import 'package:movie_night/application/domain/entities/movie/movie_genres.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/view_all_movies/view_all_movies_view_model.dart';
import 'package:movie_night/application/ui/screens/view_favorite/view_favorite_view_model.dart';
import 'package:movie_night/application/ui/widgets/vertical_widgets_with_header/vertical_movie_widget.dart';
import 'package:movie_night/application/ui/widgets/vertical_widgets_with_header/vertical_widget_with_header.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/genre.dart';
import '../../screens/main/main_view_model.dart';
import '../../screens/view_movies/view_movies_view_model.dart';

class MovieWithHeaderData {
  final String title;
  final List<Movie> list;
  final MovieGenres? movieGenres;
  final int? movieId;
  final ViewMediaType? viewMediaType;
  final ViewFavoriteType? viewFavoriteType;

  MovieWithHeaderData({
    required this.title,
    required this.list,
    this.movieGenres,
    this.movieId,
    this.viewMediaType,
    this.viewFavoriteType,
  });
}

class MoviesWithHeaderWidget extends StatelessWidget {
  final MovieWithHeaderData movieData;
  final void Function()? onPressed;
  final String? userId;

  const MoviesWithHeaderWidget({
    Key? key,
    required this.movieData,
    this.onPressed,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalWidgetWithHeaderWidget(
        title: movieData.title,
        dataLength: movieData.list.length,
        itemBuilder: (index) => VerticalMovieWidget(
              movie: movieData.list[index],
              onPressed: onPressed,
            ),
        onPressedViewAll: () async {
          try {
            context.read<MainViewModel>().showAdIfAvailable();
          } catch (e) {}
          if (movieData.movieGenres != null) {
            await Navigator.of(context).pushNamed(Screens.viewAllMovies, arguments: [
              ViewAllMoviesData(withGenres: [Genre(genre: movieData.movieGenres)]),
              MediaType.movie,
            ]);
            if (onPressed != null) onPressed!();
          } else if (movieData.viewMediaType != null && movieData.movieId != null) {
            await Navigator.of(context).pushNamed(
              Screens.viewMovies,
              arguments: ViewMoviesData(
                mediaType: MediaType.movie,
                viewMoviesType: movieData.viewMediaType!,
                mediaId: movieData.movieId!,
              ),
            );
            if (onPressed != null) onPressed!();
          } else if (movieData.viewFavoriteType != null) {
            await Navigator.of(context).pushNamed(
              Screens.viewFavorite,
              arguments: ViewFavoriteData(
                mediaType: MediaType.movie,
                favoriteType: movieData.viewFavoriteType!,
                userId: userId,
              ),
            );
            if (onPressed != null) onPressed!();
          }
        });
  }
}
