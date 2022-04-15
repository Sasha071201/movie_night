import 'package:movie_night/application/domain/entities/actor/actor_details.dart';
import 'package:movie_night/application/domain/entities/actor/actor_images.dart';
import 'package:movie_night/application/domain/entities/actor/actor_tagged_images.dart';
import 'package:movie_night/application/domain/entities/actor/popular_actors.dart';

import '../../configuration/network_configuration.dart';
import 'network_client.dart';

class ActorApiClient {
  final _networkClient = NetworkClient();

  Future<PopularActors> fetchPopularActors({
    int page = 1,
    required String locale,
  }) {
    PopularActors parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = PopularActors.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'page': '$page',
    };
    final result = _networkClient.getWithCache('/person/popular', parser, urlParameters);
    return result;
  }

  Future<ActorDetails> fetchActorDetails({
    required String locale,
    required int actorId,
    bool isCache = true,
  }) {
    ActorDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = ActorDetails.fromJson(jsonMap);
      return result;
    }
    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'language': locale,
      'append_to_response': 'combined_credits,external_ids',
    };
    if(isCache){
    final result = _networkClient.getWithCache('/person/$actorId', parser, urlParameters);
    return result;
    }
    final result = _networkClient.get('/person/$actorId', parser, urlParameters);
    return result;
  }

  Future<ActorImages> fetchActorImages({
    required int actorId,
    String? locale,
  }) {
    ActorImages parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = ActorImages.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      if (locale != null) 'language': locale,
    };
    final result =
        _networkClient.getWithCache('/person/$actorId/images', parser, urlParameters);
    return result;
  }

  Future<ActorTaggedImages> fetchActorTaggedImages({
    required int actorId,
    required int page,
    String? locale,
  }) {
    ActorTaggedImages parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = ActorTaggedImages.fromJson(jsonMap);
      return result;
    }

    final urlParameters = <String, dynamic>{
      'api_key': NetworkConfiguration.apiKey,
      'page': '$page',
      if (locale != null) 'language': locale,
    };
    final result =
        _networkClient.getWithCache('/person/$actorId/tagged_images', parser, urlParameters);
    return result;
  }
}