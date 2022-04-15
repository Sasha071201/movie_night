import 'package:movie_night/application/domain/entities/tv_shows/episode_details.dart';
import 'package:movie_night/application/domain/entities/tv_shows/episode_images.dart';
import 'package:movie_night/application/domain/entities/tv_shows/season_details.dart';
import 'package:movie_night/application/domain/entities/tv_shows/season_images.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_discover.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_images.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_on_the_air.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_popular.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_top_rated.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_shows_airing_today.dart';
import 'package:movie_night/application/utils/datetime_extension.dart';

import '../../configuration/network_configuration.dart';
import '../entities/tv_shows/tv_show_details.dart';
import 'network_client.dart';

class TvShowApiClient {
  final _networkClient = NetworkClient();

  Future<TvShowsAiringToday> fetchAiringTodayTvShows({
    int page = 1,
    required String locale,
  }) {
    TvShowsAiringToday parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowsAiringToday.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result =
        _networkClient.getWithCache('/tv/airing_today', parser, urlParameters);
    return result;
  }

  Future<TvShowOnTheAir> fetchTvShowOnTheAir({
    int page = 1,
    required String locale,
  }) {
    TvShowOnTheAir parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowOnTheAir.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result =
        _networkClient.getWithCache('/tv/on_the_air', parser, urlParameters);
    return result;
  }

  Future<TvShowPopular> fetchPopularTvShow({
    int page = 1,
    required String locale,
  }) {
    TvShowPopular parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowPopular.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result =
        _networkClient.getWithCache('/tv/popular', parser, urlParameters);
    return result;
  }

  Future<TvShowTopRated> fetchTopRatedTvShow({
    int page = 1,
    required String locale,
  }) {
    TvShowTopRated parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowTopRated.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result =
        _networkClient.getWithCache('/tv/top_rated', parser, urlParameters);
    return result;
  }

  Future<TvShowRecommendations> fetchRecommendationTvShows({
    int page = 1,
    required String locale,
    required int tvShowId,
  }) {
    TvShowRecommendations parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowRecommendations.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result = _networkClient.getWithCache(
        '/tv/$tvShowId/recommendations', parser, urlParameters);
    return result;
  }

  Future<TvShowSimilar> fetchSimilaTvShows({
    int page = 1,
    required String locale,
    required int tvShowId,
  }) {
    TvShowSimilar parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowSimilar.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result = _networkClient.getWithCache(
        '/tv/$tvShowId/similar', parser, urlParameters);
    return result;
  }

  Future<TvShowDiscover> fetchTvShows({
    required String locale,
    int page = 1,
    String sortBy = 'popularity.desc',
    String? withGenres,
    String? withoutGenres,
    DateTime? releaseDateFrom,
    DateTime? releaseDateBefore,
    double? voteAverageFrom,
    double? voteAverageBefore,
  }) {
    TvShowDiscover parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowDiscover.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
      'sort_by': sortBy,
      if (withGenres != null) 'with_genres': withGenres.toString(),
      if (withoutGenres != null) 'without_genres': withoutGenres.toString(),
      if (releaseDateFrom != null)
        'first_air_date.gte': releaseDateFrom.asApiString(),
      if (releaseDateBefore != null)
        'first_air_date.lte': releaseDateBefore.asApiString(),
      if (releaseDateBefore != null) 'include_null_first_air_dates': 'false',
      if (voteAverageFrom != null)
        'vote_average.gte': voteAverageFrom.toStringAsFixed(2), //0-10
      if (voteAverageBefore != null)
        'vote_average.lte': voteAverageBefore.toStringAsFixed(2), //0-10
    };
    final result =
        _networkClient.getWithCache('/discover/tv', parser, urlParameters);
    return result;
  }

  Future<TvShowDetails> fetchTvShowDetails({
    required String locale,
    required int tvShowId,
    bool isCache = true,
  }) {
    TvShowDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowDetails.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'append_to_response':
          'aggregate_credits,episode_groups,external_ids,keywords,recommendations,similar,videos',
    };
    if (isCache) {
      final result =
          _networkClient.getWithCache('/tv/$tvShowId', parser, urlParameters);
      return result;
    }
    final result = _networkClient.get('/tv/$tvShowId', parser, urlParameters);
    return result;
  }

  Future<TvShowImages> fetchTvShowImages({
    required int tvShowId,
    String? locale,
  }) {
    TvShowImages parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowImages.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      if (locale != null) 'language': locale,
    };
    final result = _networkClient.getWithCache(
        '/tv/$tvShowId/images', parser, urlParameters);
    return result;
  }

  Future<SeasonDetails> fetchSeasonDetails({
    required String locale,
    required int tvShowId,
    required int seasonId,
  }) {
    SeasonDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = SeasonDetails.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'append_to_response': 'aggregate_credits,videos',
    };
    final result = _networkClient.getWithCache(
        '/tv/$tvShowId/season/$seasonId', parser, urlParameters);
    return result;
  }

  Future<SeasonImages> fetchSeasonImages({
    required int tvShowId,
    required int seasonId,
    String? locale,
  }) {
    SeasonImages parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = SeasonImages.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      if (locale != null) 'language': locale,
    };
    final result = _networkClient.getWithCache(
        '/tv/$tvShowId/season/$seasonId/images', parser, urlParameters);
    return result;
  }

  Future<EpisodeDetails> fetchEpisodeDetails({
    required String locale,
    required int tvShowId,
    required int seasonId,
    required int episodeId,
  }) {
    EpisodeDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = EpisodeDetails.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'append_to_response': 'credits,videos',
    };
    final result = _networkClient.getWithCache(
        '/tv/$tvShowId/season/$seasonId/episode/$episodeId',
        parser,
        urlParameters);
    return result;
  }

  Future<EpisodeImages> fetchEpisodeImages({
    required int tvShowId,
    required int seasonId,
    required int episodeId,
    String? locale,
  }) {
    EpisodeImages parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = EpisodeImages.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      if (locale != null) 'language': locale,
    };
    final result = _networkClient.getWithCache(
        '/tv/$tvShowId/season/$seasonId/episode/$episodeId/images',
        parser,
        urlParameters);
    return result;
  }
}
