import '../../main.dart';
import '../domain/api_client/actor_api_client.dart';
import '../domain/api_client/api_client_exception.dart';
import '../domain/connectivity/connectivity_helper.dart';
import '../domain/entities/actor/actor_details.dart';
import '../domain/entities/actor/actor_images.dart';
import '../domain/entities/actor/actor_tagged_images.dart';
import '../domain/entities/actor/popular_actors.dart';

class ActorRepository {
  final _apiClient = ActorApiClient();

  Future<PopularActors> fetchPopularActors({
    int page = 1,
    required String locale,
  }) {
    return _apiClient.fetchPopularActors(locale: locale, page: page);
  }

  Future<ActorDetails> fetchActorDetails({
    required String locale,
    required int actorId,
  }) {
    return ConnectivityHelper.connectivity(
      onConnectionYes: () async {
        return _apiClient.fetchActorDetails(locale: locale, actorId: actorId);
      },
      onConnectionNo: () async {
        try {
          final favoritePerson =
              await database?.appDatabaseDao.fetchFavoritePerson(actorId);
          if (favoritePerson != null) {
            return favoritePerson.data;
          }
        } catch (e) {
          throw ApiClientException('actor-details-not-saved',e.toString());
        }
        throw ApiClientException('actor-details-not-saved',toString());
      },
    );
  }

  Future<ActorImages> fetchActorImages({
    required int actorId,
    String? locale,
  }) async {
    final hasConnection = await ConnectivityHelper.hasConnectivity();
    if (hasConnection) {
      return _apiClient.fetchActorImages(actorId: actorId, locale: locale);
    }
    return ActorImages(id: 0, profiles: []);
  }

  Future<ActorTaggedImages> fetchActorTaggedImages({
    required int actorId,
    required int page,
    String? locale,
  }) async {
    final hasConnection = await ConnectivityHelper.hasConnectivity();
    if (hasConnection) {
      return _apiClient.fetchActorTaggedImages(
          actorId: actorId, page: page, locale: locale);
    }
    return ActorTaggedImages(
        results: [], totalPages: 0, totalResults: 0, page: 0, id: 0);
  }
}
