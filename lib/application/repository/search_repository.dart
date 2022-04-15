import 'package:movie_night/application/domain/api_client/search_api_client.dart';
import 'package:movie_night/application/domain/entities/search/movie_search.dart';
import 'package:movie_night/application/domain/entities/search/multi_search.dart';
import 'package:movie_night/application/domain/entities/search/person_search.dart';
import 'package:movie_night/application/domain/entities/search/tv_show_search.dart';

class SearchRepository {
  final _apiClient = SearchApiClient();

  Future<MultiSearch> searchMulti({
    int page = 1,
    required String locale,
    required String query,
  }) {
    return _apiClient.searchMulti(page: page, locale: locale, query: query);
  }

  Future<PersonSearch> searchPeople({
    int page = 1,
    required String locale,
    required String query,
  }) {
    return _apiClient.searchPeople(page: page, locale: locale, query: query);
  }
  Future<MovieSearch> searchMovies({
    int page = 1,
    required String locale,
    required String query,
  }) {
    return _apiClient.searchMovies(page: page, locale: locale, query: query);
  }

  Future<TvShowSearch> searchTvShows({
    int page = 1,
    required String locale,
    required String query,
  }) {
    return _apiClient.searchTvShows(page: page, locale: locale, query: query);
  }
}
