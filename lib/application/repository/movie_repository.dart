import 'package:movie_night/application/domain/api_client/api_client_exception.dart';
import 'package:movie_night/application/domain/api_client/movie_api_client.dart';
import 'package:movie_night/application/domain/connectivity/connectivity_helper.dart';
import 'package:movie_night/application/domain/entities/movie/movie_now_playing.dart';
import 'package:movie_night/application/domain/entities/movie/movie_popular.dart';
import 'package:movie_night/application/domain/entities/movie/movie_top_rated.dart';
import 'package:movie_night/main.dart';

import '../domain/entities/movie/movie_details.dart';
import '../domain/entities/movie/movie_images.dart';
import '../domain/entities/movie/movies_discover.dart';
import '../domain/entities/movie/movies_upcoming.dart';

class MovieRepository {
  final _movieApiClient = MovieApiClient();

  Future<MoviesUpcoming> fetchUpcomingMovies({
    int page = 1,
    required String locale,
  }) {
    return _movieApiClient.fetchUpcomingMovies(page: page, locale: locale);
  }

  Future<MovieNowPlaying> fetchNowPlayingMovies({
    int page = 1,
    required String locale,
  }) {
    return _movieApiClient.fetchNowPlayingMovies(page: page, locale: locale);
  }

  Future<MoviePopular> fetchPopularMovies({
    int page = 1,
    required String locale,
  }) {
    return _movieApiClient.fetchPopularMovies(page: page, locale: locale);
  }

  Future<MovieTopRated> fetchTopRatedMovies({
    int page = 1,
    required String locale,
  }) {
    return _movieApiClient.fetchTopRatedMovies(page: page, locale: locale);
  }

  Future<MoviesRecommendations> fetchRecommendationMovies({
    int page = 1,
    required String locale,
    required int movieId,
  }) {
    return _movieApiClient.fetchRecommendationMovies(
      page: page,
      locale: locale,
      movieId: movieId,
    );
  }

  Future<MoviesSimilar> fetchSimilarMovies({
    int page = 1,
    required String locale,
    required int movieId,
  }) {
    return _movieApiClient.fetchSimilarMovies(
      page: page,
      locale: locale,
      movieId: movieId,
    );
  }

  Future<MoviesDiscover> fetchMovies({
    required String locale,
    int page = 1,
    String sortBy = 'popularity.desc',
    String? withGenres,
    String? withoutGenres,
    bool? includeAdult,
    String? withReleaseType,
    DateTime? releaseDateFrom,
    DateTime? releaseDateBefore,
    double? voteAverageFrom,
    double? voteAverageBefore,
  }) {
    return _movieApiClient.fetchMovies(
        locale: locale,
        page: page,
        sortBy: sortBy,
        withGenres: withGenres,
        withoutGenres: withoutGenres,
        includeAdult: includeAdult,
        withReleaseType: withReleaseType,
        releaseDateFrom: releaseDateFrom,
        releaseDateBefore: releaseDateBefore,
        voteAverageFrom: voteAverageFrom,
        voteAverageBefore: voteAverageBefore);
  }

  Future<MovieDetails> fetchMovieDetails({
    required String locale,
    required int movieId,
  }) {
    return ConnectivityHelper.connectivity<MovieDetails>(
      onConnectionYes: () async {
        return _movieApiClient.fetchMovieDetails(
          locale: locale,
          movieId: movieId,
        );
      },
      onConnectionNo: () async {
        try {
          final favoriteMovie =
              await database?.appDatabaseDao.fetchFavoriteMovie(movieId);
          if (favoriteMovie != null) {
            return favoriteMovie.data;
          }
        } catch (e) {
          try {
            final watchedMovie =
                await database?.appDatabaseDao.fetchWatchedMovie(movieId);
            if (watchedMovie != null) {
              return watchedMovie.data;
            }
          } catch (e) {
            throw ApiClientException('movie-details-not-saved');
          }
        }
        throw ApiClientException('movie-details-not-saved');
      },
    );
  }

  Future<MovieImages> fetchMovieImages({
    required int movieId,
    String? locale,
  }) async {
    final hasConnection = await ConnectivityHelper.hasConnectivity();
    if (hasConnection) {
      return _movieApiClient.fetchMovieImages(movieId: movieId, locale: locale);
    }
    return MovieImages(backdrops: [], posters: [], logos: [], id: 0);
  }
}
