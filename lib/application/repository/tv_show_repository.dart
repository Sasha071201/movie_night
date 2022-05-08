import 'package:movie_night/application/domain/api_client/tv_show_api_client.dart';
import 'package:movie_night/application/domain/connectivity/connectivity_helper.dart';
import 'package:movie_night/application/domain/entities/tv_shows/episode_details.dart';
import 'package:movie_night/application/domain/entities/tv_shows/episode_images.dart';
import 'package:movie_night/application/domain/entities/tv_shows/season_details.dart';
import 'package:movie_night/application/domain/entities/tv_shows/season_images.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_images.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_on_the_air.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_popular.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_top_rated.dart';

import '../../main.dart';
import '../domain/api_client/api_client_exception.dart';
import '../domain/entities/tv_shows/tv_show_details.dart';
import '../domain/entities/tv_shows/tv_show_discover.dart';
import '../domain/entities/tv_shows/tv_shows_airing_today.dart';

class TvShowRepository {
  final _apiClient = TvShowApiClient();

  Future<TvShowsAiringToday> fetchAiringTodayTvShows({
    int page = 1,
    required String locale,
  }) {
    return _apiClient.fetchAiringTodayTvShows(locale: locale, page: page);
  }

  Future<TvShowOnTheAir> fetchTvShowOnTheAir({
    int page = 1,
    required String locale,
  }) {
    return _apiClient.fetchTvShowOnTheAir(page: page, locale: locale);
  }

  Future<TvShowPopular> fetchPopularTvShow({
    int page = 1,
    required String locale,
  }) {
    return _apiClient.fetchPopularTvShow(page: page, locale: locale);
  }

  Future<TvShowTopRated> fetchTopRatedTvShow({
    int page = 1,
    required String locale,
  }) {
    return _apiClient.fetchTopRatedTvShow(page: page, locale: locale);
  }

  Future<TvShowRecommendations> fetchRecommendationTvShows({
    int page = 1,
    required String locale,
    required int tvShowId,
  }) {
    return _apiClient.fetchRecommendationTvShows(
      locale: locale,
      page: page,
      tvShowId: tvShowId,
    );
  }

  Future<TvShowSimilar> fetchSimilarTvShows({
    int page = 1,
    required String locale,
    required int tvShowId,
  }) {
    return _apiClient.fetchSimilaTvShows(
      locale: locale,
      page: page,
      tvShowId: tvShowId,
    );
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
    return _apiClient.fetchTvShows(
      locale: locale,
      page: page,
      sortBy: sortBy,
      withGenres: withGenres,
      withoutGenres: withoutGenres,
      releaseDateBefore: releaseDateBefore,
      releaseDateFrom: releaseDateFrom,
      voteAverageFrom: voteAverageFrom,
      voteAverageBefore: voteAverageBefore,
    );
  }

  Future<TvShowDetails> fetchTvShowDetails({
    required String locale,
    required int tvShowId,
  }) {
    return ConnectivityHelper.connectivity(
      onConnectionYes: () async {
        return _apiClient.fetchTvShowDetails(
          locale: locale,
          tvShowId: tvShowId,
        );
      },
      onConnectionNo: () async {
        try {
          final favoriteTvShow =
              await database?.appDatabaseDao.fetchFavoriteTvShow(tvShowId);
          if (favoriteTvShow != null) {
            return favoriteTvShow.data;
          }
        } catch (e) {
          try {
            final watchedTvShow =
                await database?.appDatabaseDao.fetchWatchedTvShow(tvShowId);
            if (watchedTvShow != null) {
              return watchedTvShow.data;
            }
          } catch (e) {
            throw ApiClientException('serial-details-not-saved');
          }
        }
        throw ApiClientException('serial-details-not-saved');
      },
    );
  }

  Future<TvShowImages> fetchTvShowImages({
    required int tvShowId,
    String? locale,
  }) async {
    final hasConnection = await ConnectivityHelper.hasConnectivity();
    if (hasConnection) {
      return _apiClient.fetchTvShowImages(tvShowId: tvShowId, locale: locale);
    }
    return TvShowImages(backdrops: [], posters: [], logos: [], id: 0);
  }

  Future<SeasonDetails> fetchSeasonDetails({
    required String locale,
    required int tvShowId,
    required int seasonId,
  }) {
    return _apiClient.fetchSeasonDetails(
      locale: locale,
      tvShowId: tvShowId,
      seasonId: seasonId,
    );
  }

  Future<SeasonImages> fetchSeasonImages({
    required int tvShowId,
    required int seasonId,
    String? locale,
  }) {
    return _apiClient.fetchSeasonImages(
      locale: locale,
      tvShowId: tvShowId,
      seasonId: seasonId,
    );
  }

  Future<EpisodeDetails> fetchEpisodeDetails({
    required String locale,
    required int tvShowId,
    required int seasonId,
    required int episodeId,
  }) {
    return _apiClient.fetchEpisodeDetails(
      locale: locale,
      tvShowId: tvShowId,
      seasonId: seasonId,
      episodeId: episodeId,
    );
  }

  Future<EpisodeImages> fetchEpisodeImages({
    required int tvShowId,
    required int seasonId,
    required int episodeId,
    String? locale,
  }) {
    return _apiClient.fetchEpisodeImages(
      locale: locale,
      tvShowId: tvShowId,
      seasonId: seasonId,
      episodeId: episodeId,
    );
  }
}
