import 'dart:async';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/entities/actor/actor_details.dart';
import 'package:movie_night/application/ui/notifications/app_notification_manager.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

import '../../ui/screens/view_favorite/view_favorite_view_model.dart';
import '../api_client/actor_api_client.dart';
import '../api_client/movie_api_client.dart';
import '../api_client/tv_show_api_client.dart';
import '../database/database.dart';
import '../entities/movie/movie_details.dart';
import '../entities/tv_shows/tv_show_details.dart';

class CheckUpdateTaskHandler extends TaskHandler {
  final _movieApiClient = MovieApiClient();
  final _tvShowApiClient = TvShowApiClient();
  final _actorApiClient = ActorApiClient();
  String locale = '';
  AppDatabase? _database;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    SharedPreferencesAndroid.registerWith();
    print('foreground onStart');
    final completer = Completer<bool>();
    try {
      final spawnerReceivePort = ReceivePort();
      sendPort?.send(spawnerReceivePort.sendPort);
      spawnerReceivePort.listen((message) async {
        if (message is SendPort) {
          await _initDatabase(message);
          completer.complete(true);
        }
      });
    } catch (e) {
      completer.completeError(e);
      print(e);
    }
    await completer.future;
    try {
      locale =
          await FlutterForegroundTask.getData<String>(key: 'locale') ?? 'ru';
      await _addMoviesToDatabaseAndCheckUpdates();
      await _addTvShowsToDatabaseAndCheckUpdates();
      await _addPeopleToDatabaseAndCheckUpdates();
    } catch (e) {
      print(e);
    }

    await FlutterForegroundTask.stopService();
  }

  Future<void> _initDatabase(SendPort connectionPort) async {
    final connection = DatabaseConnection.delayed(() async {
      final isolate = DriftIsolate.fromConnectPort(connectionPort);
      return await isolate.connect();
    }());
    _database = AppDatabase.connect(connection);
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    print('foreground onEvent');
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    print('foreground onDestroy');
  }

  Future<void> _addMoviesToDatabaseAndCheckUpdates() async {
    try {
      List<MovieDetails>? favoriteMovies;
      try {
        favoriteMovies = (await _database?.appDatabaseDao.fetchFavoriteMovies())
            ?.map((e) => e.data)
            .toList();
      } catch (e) {}
      if (favoriteMovies != null) {
        for (var i = 0; i < favoriteMovies.length; i++) {
          await _checkUpdateMovie(
            favoriteMovies[i],
            ViewFavoriteType.favorite,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkUpdateMovie(
    MovieDetails movieFromDB,
    ViewFavoriteType viewFavoriteType,
  ) async {
    final newMovieDetails = await _movieApiClient.fetchMovieDetails(
      locale: locale,
      movieId: movieFromDB.id!,
      isCache: false,
    );
    String textUpdated = '';
    final overviewFromDB = movieFromDB.overview;
    final releaseDateFromDB = movieFromDB.releaseDate;
    final statusFromDB = movieFromDB.status;
    final videosFromDB = movieFromDB.videos;
    final resultOverviewCompare =
        newMovieDetails.overview?.compareTo(overviewFromDB ?? '');
    final resultReleaseDateCompare = newMovieDetails.releaseDate
        ?.compareTo(releaseDateFromDB ?? DateTime.now());
    final resultStatusCompare =
        newMovieDetails.status?.compareTo(statusFromDB ?? '');
    if (resultOverviewCompare != 0) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Описание изменилось';
      } else {
        textUpdated = 'Description has changed';
      }
    } else if (resultReleaseDateCompare != 0) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Дата релиза изменилась';
      } else {
        textUpdated = 'Release date has changed';
      }
    } else if (resultStatusCompare != 0) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Статус изменился на ${newMovieDetails.status ?? 'Неизвестный'}';
      } else {
        textUpdated = 'Status changed to ${newMovieDetails.status ?? 'Unknown'}';
      }
    } else if (videosFromDB != null &&
        videosFromDB.results.isEmpty &&
        newMovieDetails.videos?.results != null &&
        newMovieDetails.videos!.results.isNotEmpty) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Появился трейлер';
      } else {
        textUpdated = 'A trailer has appeared';
      }
    }
    if (textUpdated.isNotEmpty) {
      final title =
          newMovieDetails.title != null && newMovieDetails.title!.isNotEmpty
              ? newMovieDetails.title
              : 'Unknown';
      final id = newMovieDetails.id;
      AppNotificationManager.showNotification(
        id: id ?? 0,
        title: '$title',
        body: textUpdated,
        payload: 'movie-$id',
      );
      await _insertMovieToDB(newMovieDetails, viewFavoriteType);
    }
  }

  Future<void> _insertMovieToDB(
    MovieDetails movieDetails,
    ViewFavoriteType type,
  ) async {
    await _database?.appDatabaseDao.insertMovie(movieDetails, type);
  }

  Future<void> _addTvShowsToDatabaseAndCheckUpdates() async {
    try {
      List<TvShowDetails>? favoriteTvShows;
      try {
        favoriteTvShows =
            (await _database?.appDatabaseDao.fetchFavoriteTvShows())
                ?.map((e) => e.data)
                .toList();
      } catch (e) {}
      if (favoriteTvShows != null) {
        for (var i = 0; i < favoriteTvShows.length; i++) {
          await _checkUpdateTvShow(
            favoriteTvShows[i],
            ViewFavoriteType.favorite,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkUpdateTvShow(
    TvShowDetails tvShowFromDB,
    ViewFavoriteType viewFavoriteType,
  ) async {
    final newTvShowDetails = await _tvShowApiClient.fetchTvShowDetails(
      locale: locale,
      tvShowId: tvShowFromDB.id,
      isCache: false,
    );
    String textUpdated = '';
    final overviewFromDB = tvShowFromDB.overview;
    final firstAirDateFromDB = tvShowFromDB.firstAirDate;
    final statusFromDB = tvShowFromDB.status;
    final videosFromDB = tvShowFromDB.videos;
    final numberOfSeasons = tvShowFromDB.numberOfSeasons;
    final numberOfEpisodes = tvShowFromDB.numberOfEpisodes;
    if (newTvShowDetails.overview.compareTo(overviewFromDB) != 0) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Описание изменилось';
      } else {
        textUpdated = 'Description has changed';
      }
    } else if (firstAirDateFromDB != null &&
        newTvShowDetails.firstAirDate?.compareTo(firstAirDateFromDB) != 0) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Дата релиза изменилась';
      } else {
        textUpdated = 'Release date has changed';
      }
    } else if (newTvShowDetails.status.compareTo(statusFromDB) != 0) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Статус изменился на ${newTvShowDetails.status}';
      } else {
        textUpdated = 'Status changed to ${newTvShowDetails.status}';
      }
    } else if (newTvShowDetails.numberOfSeasons > numberOfSeasons) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Появился ${newTvShowDetails.numberOfSeasons} сезон}';
      } else {
        textUpdated = 'Season ${newTvShowDetails.numberOfSeasons} has appeared';
      }
    } else if (newTvShowDetails.numberOfEpisodes > numberOfEpisodes) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Появился ${newTvShowDetails.numberOfEpisodes} эпизод';
      } else {
        textUpdated =
            'Episode ${newTvShowDetails.numberOfEpisodes} has appeared';
      }
    } else if (videosFromDB.results.isEmpty &&
        newTvShowDetails.videos.results.isNotEmpty) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Появился трейлер';
      } else {
        textUpdated = 'A trailer has appeared';
      }
    }
    if (textUpdated.isNotEmpty) {
      final title =
          newTvShowDetails.name.isNotEmpty ? newTvShowDetails.name : 'Unknown';
      final id = newTvShowDetails.id;
      AppNotificationManager.showNotification(
        id: id,
        title: title,
        body: textUpdated,
        payload: 'tv-$id',
      );
      await _insertTvShowToDB(newTvShowDetails, viewFavoriteType);
    }
  }

  Future<void> _insertTvShowToDB(
    TvShowDetails tvShowDetails,
    ViewFavoriteType type,
  ) async {
    await _database?.appDatabaseDao.insertTvShow(tvShowDetails, type);
  }

  Future<void> _addPeopleToDatabaseAndCheckUpdates() async {
    try {
      List<ActorDetails>? favoritePeople;
      try {
        favoritePeople = (await _database?.appDatabaseDao.fetchFavoritePeople())
            ?.map((e) => e.data)
            .toList();
      } catch (e) {}
      if (favoritePeople != null) {
        for (var i = 0; i < favoritePeople.length; i++) {
          await _checkUpdatePeson(
            favoritePeople[i],
            ViewFavoriteType.favorite,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkUpdatePeson(
    ActorDetails personFromDB,
    ViewFavoriteType viewFavoriteType,
  ) async {
    final newPersonDetails = await _actorApiClient.fetchActorDetails(
      locale: locale,
      actorId: personFromDB.id,
      isCache: false,
    );
    String textUpdated = '';
    final overviewFromDB = personFromDB.biography;
    final castFromDB = personFromDB.combinedCredits.cast;
    final crewFromDB = personFromDB.combinedCredits.crew;
    if (overviewFromDB != null &&
        newPersonDetails.biography?.compareTo(overviewFromDB) != 0) {
      if (locale.compareTo('ru') == 0) {
        textUpdated = 'Биография изменилась';
      } else {
        textUpdated = 'Biography has changed';
      }
    } else if (castFromDB.length !=
        newPersonDetails.combinedCredits.cast.length) {
      for (var i = 0; i < newPersonDetails.combinedCredits.cast.length; i++) {
        final items = newPersonDetails.combinedCredits.cast;
        if (!castFromDB.contains(items[i])) {
          final mediaTypeString = items[i].mediaType == MediaType.movie
              ? locale.compareTo('ru') == 0
                  ? 'фильм'
                  : 'movie'
              : locale.compareTo('ru') == 0
                  ? 'сериал'
                  : 'series';
          if (locale.compareTo('ru') == 0) {
            textUpdated =
                'Появился новый $mediaTypeString${items[i].title ?? ''}${items[i].character != null ? ', в котором он играл ${items[i].character}' : ''}';
          } else {
            textUpdated =
                'There was a new $mediaTypeString ${items[i].title ?? ''}${items[i].character != null ? ', in which he played ${items[i].character}' : ''}';
          }
        }
      }
    } else if (crewFromDB.length !=
        newPersonDetails.combinedCredits.crew.length) {
      for (var i = 0; i < newPersonDetails.combinedCredits.crew.length; i++) {
        final items = newPersonDetails.combinedCredits.crew;
        if (!crewFromDB.contains(items[i])) {
          final mediaTypeString = items[i].mediaType == MediaType.movie
              ? locale.compareTo('ru') == 0
                  ? 'фильм'
                  : 'movie'
              : locale.compareTo('ru') == 0
                  ? 'сериал'
                  : 'series';
          if (locale.compareTo('ru') == 0) {
            textUpdated =
                'Появился новый $mediaTypeString ${items[i].title ?? ''}${items[i].job != null ? ', в котором он был ${items[i].job}' : ''}';
          } else {
            textUpdated =
                'There was a new $mediaTypeString ${items[i].title ?? ''}${items[i].job != null ? ', in which he was the ${items[i].job}' : ''}';
          }
        }
      }
    }
    if (textUpdated.isNotEmpty) {
      final title =
          newPersonDetails.name.isNotEmpty ? newPersonDetails.name : 'Unknown';
      final id = newPersonDetails.id;
      AppNotificationManager.showNotification(
        id: id,
        title: title,
        body: textUpdated,
        payload: 'person-$id',
      );
      await _insertPersonToDB(newPersonDetails);
    }
  }

  Future<void> _insertPersonToDB(
    ActorDetails personDetails,
  ) async {
    await _database?.appDatabaseDao.insertPerson(personDetails);
  }
}
