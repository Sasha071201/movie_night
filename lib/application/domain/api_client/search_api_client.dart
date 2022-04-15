import 'package:movie_night/application/domain/entities/find/media_find.dart';
import 'package:movie_night/application/domain/entities/search/movie_search.dart';
import 'package:movie_night/application/domain/entities/search/multi_search.dart';
import 'package:movie_night/application/domain/entities/search/person_search.dart';
import 'package:movie_night/application/domain/entities/search/tv_show_search.dart';

import '../../configuration/network_configuration.dart';
import 'network_client.dart';

class SearchApiClient {
  final _networkClient = NetworkClient();

  Future<MediaFind> findById({
    required String id,
    required String locale,
  }) {
    MediaFind parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MediaFind.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'external_source': 'imdb_id'
    };
    final result = _networkClient.getWithCache('/find/$id', parser, urlParameters);
    return result;
  }

  Future<MultiSearch> searchMulti({
    int page = 1,
    required String query,
    required String locale,
  }) {
    MultiSearch parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MultiSearch.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
      'query': query,
    };
    final result = _networkClient.getWithCache('/search/multi', parser, urlParameters);
    return result;
  }

  Future<MovieSearch> searchMovies({
    int page = 1,
    required String query,
    required String locale,
  }) {
    MovieSearch parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = MovieSearch.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
      'query': query,
    };
    final result = _networkClient.getWithCache('/search/movie', parser, urlParameters);
    return result;
  }

  Future<TvShowSearch> searchTvShows({
    int page = 1,
    required String query,
    required String locale,
  }) {
    TvShowSearch parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = TvShowSearch.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
      'query': query,
    };
    final result = _networkClient.getWithCache('/search/tv', parser, urlParameters);
    return result;
  }

  Future<PersonSearch> searchPeople({
    int page = 1,
    required String query,
    required String locale,
  }) {
    PersonSearch parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = PersonSearch.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
      'query': query,
    };
    final result = _networkClient.getWithCache('/search/person', parser, urlParameters);
    return result;
  }
}
