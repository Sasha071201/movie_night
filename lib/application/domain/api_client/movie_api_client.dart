import 'package:movie_night/application/configuration/network_configuration.dart';
import 'package:movie_night/application/domain/api_client/network_client.dart';
import 'package:movie_night/application/domain/entities/movie/movie_images.dart';
import 'package:movie_night/application/domain/entities/movie/movie_now_playing.dart';
import 'package:movie_night/application/domain/entities/movie/movie_popular.dart';
import 'package:movie_night/application/domain/entities/movie/movie_top_rated.dart';
import 'package:movie_night/application/utils/datetime_extension.dart';

import '../entities/movie/movie_details.dart';
import '../entities/movie/movies_discover.dart';
import '../entities/movie/movies_upcoming.dart';

class MovieApiClient {
  final _networkClient = NetworkClient();

  Future<MoviesUpcoming> fetchUpcomingMovies({
    int page = 1,
    required String locale,
  }) {
    MoviesUpcoming parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MoviesUpcoming.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result =
        _networkClient.getWithCache('/movie/upcoming', parser, urlParameters);
    return result;
  }

  Future<MovieNowPlaying> fetchNowPlayingMovies({
    int page = 1,
    required String locale,
  }) {
    MovieNowPlaying parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MovieNowPlaying.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result = _networkClient.getWithCache(
        '/movie/now_playing', parser, urlParameters);
    return result;
  }

  Future<MoviePopular> fetchPopularMovies({
    int page = 1,
    required String locale,
  }) {
    MoviePopular parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MoviePopular.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result =
        _networkClient.getWithCache('/movie/popular', parser, urlParameters);
    return result;
  }

  Future<MovieTopRated> fetchTopRatedMovies({
    int page = 1,
    required String locale,
  }) {
    MovieTopRated parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MovieTopRated.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result =
        _networkClient.getWithCache('/movie/top_rated', parser, urlParameters);
    return result;
  }

  Future<MoviesRecommendations> fetchRecommendationMovies({
    int page = 1,
    required String locale,
    required int movieId,
  }) {
    MoviesRecommendations parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MoviesRecommendations.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result = _networkClient.getWithCache(
        '/movie/$movieId/recommendations', parser, urlParameters);
    return result;
  }

  Future<MoviesSimilar> fetchSimilarMovies({
    int page = 1,
    required String locale,
    required int movieId,
  }) {
    MoviesSimilar parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MoviesSimilar.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result = _networkClient.getWithCache(
        '/movie/$movieId/similar', parser, urlParameters);
    return result;
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
    MoviesDiscover parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MoviesDiscover.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
      'sort_by': sortBy,
      if (withGenres != null) 'with_genres': withGenres.toString(),
      if (withoutGenres != null) 'without_genres': withoutGenres.toString(),
      'include_adult': 'false',
      if (withReleaseType != null)
        'with_release_type': withReleaseType.toString(),
      if (releaseDateFrom != null)
        'release_date.gte': releaseDateFrom.asApiString(),
      if (releaseDateBefore != null)
        'release_date.lte': releaseDateBefore.asApiString(),
      if (voteAverageFrom != null)
        'vote_average.gte': voteAverageFrom.toStringAsFixed(2), //0-10
      if (voteAverageBefore != null)
        'vote_average.lte': voteAverageBefore.toStringAsFixed(2), //0-10
    };
    final result =
        _networkClient.getWithCache('/discover/movie', parser, urlParameters);
    return result;
  }

  Future<MovieDetails> fetchMovieDetails(
      {required String locale, required int movieId, bool isCache = true}) {
    MovieDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MovieDetails.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'append_to_response':
          'credits,videos,external_ids,keywords,recommendations,similar',
    };
    if (isCache) {
      final result =
          _networkClient.getWithCache('/movie/$movieId', parser, urlParameters);
      return result;
    }
    final result = _networkClient.get('/movie/$movieId', parser, urlParameters);
    return result;
  }

  Future<MovieImages> fetchMovieImages({
    required int movieId,
    String? locale,
  }) {
    MovieImages parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MovieImages.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      if (locale != null) 'language': locale,
    };
    final result = _networkClient.getWithCache(
        '/movie/$movieId/images', parser, urlParameters);
    return result;
  }
}
