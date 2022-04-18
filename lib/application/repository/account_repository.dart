import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_night/application/configuration/firebase_configuration.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/connectivity/connectivity_helper.dart';
import 'package:movie_night/application/domain/entities/actor/actor.dart';
import 'package:movie_night/application/domain/entities/actor/actor_details.dart';
import 'package:movie_night/application/domain/entities/complaint_review.dart';
import 'package:movie_night/application/domain/entities/movie/movie_details.dart';
import 'package:movie_night/application/domain/entities/review.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_details.dart';
import 'package:movie_night/application/ui/screens/view_favorite/view_favorite_view_model.dart';

import '../../main.dart';
import '../domain/api_client/account_api_client.dart';
import '../domain/api_client/actor_api_client.dart';
import '../domain/api_client/movie_api_client.dart';
import '../domain/api_client/search_api_client.dart';
import '../domain/api_client/tv_show_api_client.dart';
import '../domain/entities/movie/movie.dart';

class AccountRepository {
  final _accountApiClient = AccountApiClient();
  final _movieApiClient = MovieApiClient();
  final _tvShowApiClient = TvShowApiClient();
  final _actorApiClient = ActorApiClient();
  final _searchApiClient = SearchApiClient();

  Future<bool> uploadProfileImage({
    required String fileName,
    required File file,
  }) async {
    return await _accountApiClient.uploadProfileImage(
      fileName: fileName,
      file: file,
    );
  }

  Future<void> sendReview({
    required String mediaId,
    required Review review,
  }) async {
    return await _accountApiClient.sendReview(mediaId: mediaId, review: review);
  }

  Future<bool> sendComplaintToReview(ComplaintReview complaintReview) async {
    return await _accountApiClient.sendComplaintToReview(complaintReview);
  }

  Future<void> deleteReview({
    required String mediaId,
    required String reviewId,
  }) async {
    return await _accountApiClient.deleteReview(
      mediaId: mediaId,
      reviewId: reviewId,
    );
  }

  Future<void> setUserName(String name) async {
    return await _accountApiClient.setUserName(name);
  }

  Future<String> fetchUserName() async {
    return await _accountApiClient.fetchUserName();
  }

  Future<String> fetchUserProfileImageUrl() async {
    return await _accountApiClient.fetchUserProfileImageUrl();
  }

  Future<void> favoriteMovie(String movieId) async {
    return await _accountApiClient.favoriteMovie(movieId);
  }

  Future<void> favoriteTvShow(String tvShowId) async {
    return await _accountApiClient.favoriteTvShow(tvShowId);
  }

  Future<void> favoritePerson(String personId) async {
    await _accountApiClient.favoritePerson(personId);
  }

  Future<bool?> isFavoriteMovie(String movieId) async {
    return await _accountApiClient.isFavoriteMovie(movieId);
  }

  Future<bool?> isFavoriteTvShow(String tvShowId) async {
    return await _accountApiClient.isFavoriteTvShow(tvShowId);
  }

  Future<bool?> isFavoritePerson(String personId) async {
    return await _accountApiClient.isFavoritePerson(personId);
  }

  Future<void> watchMovie(String movieId) async {
    return await _accountApiClient.watchMovie(movieId);
  }

  Future<void> watchTvShow(String tvShowId) async {
    return await _accountApiClient.watchTvShow(tvShowId);
  }

  Future<bool?> isWatchedMovie(String movieId) async {
    return await _accountApiClient.isWatchedMovie(movieId);
  }

  Future<bool?> isWatchedTvShow(String tvShowId) async {
    return await _accountApiClient.isWatchedTvShow(tvShowId);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> favoriteStream() =>
      _accountApiClient.favoriteStream();

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchedStream() =>
      _accountApiClient.watchedStream();

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream() =>
      _accountApiClient.userStream();

  Stream<List<Review>> reviewsStream(String id) =>
      _accountApiClient.reviewsStream(id).asyncMap((event) async {
        final List<Review> listResult = [];
        for (var i = 0; i < event.docs.length; i++) {
          await Future.delayed(Duration.zero);
          final userId = event.docs[i].get(FirebaseConfiguration.userIdField);
          listResult.add(
            Review(
                id: event.docs[i].id,
                name: await _accountApiClient.fetchUserName(userId),
                avatarUrl:
                    await _accountApiClient.fetchUserProfileImageUrl(userId),
                userId: userId,
                date:
                    event.docs[i].get(FirebaseConfiguration.dateField).toDate(),
                review: event.docs[i].get(FirebaseConfiguration.reviewField),
                isMine: userId == _accountApiClient.uid),
          );
        }
        return listResult..sort((a, b) => a.date.compareTo(b.date));
      });

  Future<List<Movie>> fetchWatchedMovies(String locale, int? maxLength) async {
    return ConnectivityHelper.connectivity<List<Movie>>(
      onConnectionYes: () async {
        final ids = await _accountApiClient.fetchWatchedMovies();
        final movies = <Movie>[];
        final length = maxLength != null && maxLength < ids.length
            ? maxLength
            : ids.length;
        for (var i = 0; i < length; i++) {
          await Future.delayed(Duration.zero);
          final response =
              await _searchApiClient.findById(id: ids[i], locale: locale);
          final movie = response.movieResults.first;
          movies.add(movie);
          await Future.delayed(Duration.zero);
          _addMovieToDatabaseAndCheckUpdates(
              locale, movie, ViewFavoriteType.watched);
        }
        if (maxLength == null || maxLength > ids.length) {
          _deleteOldMediaFromDB(
              movies, MediaType.movie, ViewFavoriteType.watched);
        }
        return movies;
      },
      onConnectionNo: () async {
        return await _fetchMappedMediaFromDB<Movie>(
          MediaType.movie,
          ViewFavoriteType.watched,
        );
      },
    );
  }

  Future<List<TvShow>> fetchWatchedTvShows(
    String locale,
    int? maxLength,
  ) async {
    return ConnectivityHelper.connectivity<List<TvShow>>(
      onConnectionYes: () async {
        final ids = await _accountApiClient.fetchWatchedTvShows();
        final tvShows = <TvShow>[];
        final length = maxLength != null && maxLength < ids.length
            ? maxLength
            : ids.length;
        for (var i = 0; i < length; i++) {
          await Future.delayed(Duration.zero);
          final response =
              await _searchApiClient.findById(id: ids[i], locale: locale);
          final tvShow = response.tvResults.first;
          tvShows.add(tvShow);
          await Future.delayed(Duration.zero);
          _addTvShowToDatabaseAndCheckUpdates(
              locale, tvShow, ViewFavoriteType.watched);
        }
        if (maxLength == null || maxLength > ids.length) {
          _deleteOldMediaFromDB(
              tvShows, MediaType.tv, ViewFavoriteType.watched);
        }
        return tvShows;
      },
      onConnectionNo: () async {
        return await _fetchMappedMediaFromDB<TvShow>(
          MediaType.tv,
          ViewFavoriteType.watched,
        );
      },
    );
  }

  Future<List<Movie>> fetchFavoriteMovies(String locale, int? maxLength) async {
    return ConnectivityHelper.connectivity<List<Movie>>(
      onConnectionYes: () async {
        final ids = await _accountApiClient.fetchFavoriteMovies();
        final movies = <Movie>[];
        final length = maxLength != null && maxLength < ids.length
            ? maxLength
            : ids.length;
        for (var i = 0; i < length; i++) {
          await Future.delayed(Duration.zero);
          final response =
              await _searchApiClient.findById(id: ids[i], locale: locale);
          final movie = response.movieResults.first;
          movies.add(movie);
          await Future.delayed(Duration.zero);
          _addMovieToDatabaseAndCheckUpdates(
              locale, movie, ViewFavoriteType.favorite);
        }
        if (maxLength == null || maxLength > ids.length) {
          _deleteOldMediaFromDB(
              movies, MediaType.movie, ViewFavoriteType.favorite);
        }
        return movies;
      },
      onConnectionNo: () async {
        return await _fetchMappedMediaFromDB<Movie>(
          MediaType.movie,
          ViewFavoriteType.favorite,
        );
      },
    );
  }

  Future<void> _deleteOldMediaFromDB(
    List<dynamic> media,
    MediaType mediaType,
    ViewFavoriteType viewFavoriteType,
  ) async {
    try {
      List<dynamic>? mediaFromDB =
          (await _fetchMediaFromDB(mediaType, viewFavoriteType))
              .map((e) => e.data)
              .toList();
      final idsMedia = media.map((e) => e.id);
      final mediaNeedDelete = mediaFromDB
          .where((element) => !idsMedia.contains(element.id))
          .toList();
      for (var i = 0; i < mediaNeedDelete.length; i++) {
        String imdbId = '';
        switch (mediaType) {
          case MediaType.movie:
            imdbId = mediaNeedDelete[i].imdbId!;
            switch (viewFavoriteType) {
              case ViewFavoriteType.favorite:
                await database?.appDatabaseDao.deleteFavoriteMovie(imdbId);
                break;
              case ViewFavoriteType.favoriteAndNotWatched:
                await database?.appDatabaseDao
                    .deleteFavoriteAndNotWatchedMovie(imdbId);
                break;
              case ViewFavoriteType.watched:
                await database?.appDatabaseDao.deleteWatchedMovie(imdbId);
                break;
            }
            break;
          case MediaType.tv:
            imdbId = mediaNeedDelete[i].externalIds.imdbId!;
            switch (viewFavoriteType) {
              case ViewFavoriteType.favorite:
                await database?.appDatabaseDao.deleteFavoriteTvShow(imdbId);
                break;
              case ViewFavoriteType.favoriteAndNotWatched:
                await database?.appDatabaseDao
                    .deleteFavoriteAndNotWatchedTvShow(imdbId);
                break;
              case ViewFavoriteType.watched:
                await database?.appDatabaseDao.deleteWatchedTvShow(imdbId);
                break;
            }
            break;
          case MediaType.person:
            imdbId = mediaNeedDelete[i].imdbId!;
            switch (viewFavoriteType) {
              case ViewFavoriteType.favorite:
                await database?.appDatabaseDao.deleteFavoritePerson(imdbId);
                break;
              case ViewFavoriteType.favoriteAndNotWatched:
                break;
              case ViewFavoriteType.watched:
                break;
            }
            break;
        }
      }
      return;
    } catch (e) {
    }
  }

  Future<List<TvShow>> fetchFavoriteTvShows(
    String locale,
    int? maxLength,
  ) async {
    return ConnectivityHelper.connectivity<List<TvShow>>(
      onConnectionYes: () async {
        final ids = await _accountApiClient.fetchFavoriteTvShows();
        final tvShows = <TvShow>[];
        final length = maxLength != null && maxLength < ids.length
            ? maxLength
            : ids.length;
        for (var i = 0; i < length; i++) {
          await Future.delayed(Duration.zero);
          final response =
              await _searchApiClient.findById(id: ids[i], locale: locale);
          final tvShow = response.tvResults.first;
          tvShows.add(tvShow);
          await Future.delayed(Duration.zero);
          _addTvShowToDatabaseAndCheckUpdates(
              locale, tvShow, ViewFavoriteType.favorite);
        }
        if (maxLength == null || maxLength > ids.length) {
          _deleteOldMediaFromDB(
              tvShows, MediaType.tv, ViewFavoriteType.favorite);
        }
        return tvShows;
      },
      onConnectionNo: () async {
        return await _fetchMappedMediaFromDB<TvShow>(
          MediaType.tv,
          ViewFavoriteType.favorite,
        );
      },
    );
  }

  Future<List<Actor>> fetchFavoritePeople(String locale, int? maxLength) async {
    return ConnectivityHelper.connectivity<List<Actor>>(
      onConnectionYes: () async {
        final ids = await _accountApiClient.fetchFavoritePeople();
        final people = <Actor>[];
        final length = maxLength != null && maxLength < ids.length
            ? maxLength
            : ids.length;
        for (var i = 0; i < length; i++) {
          await Future.delayed(Duration.zero);
          final response =
              await _searchApiClient.findById(id: ids[i], locale: locale);
          final person = response.personResults.first;
          people.add(person);
          await Future.delayed(Duration.zero);
          _addPersonToDatabaseAndCheckUpdates(
              locale, person, ViewFavoriteType.favorite);
        }
        if (maxLength == null || maxLength > ids.length) {
          _deleteOldMediaFromDB(
              people, MediaType.person, ViewFavoriteType.favorite);
        }
        return people;
      },
      onConnectionNo: () async {
        return await _fetchMappedMediaFromDB<Actor>(
          MediaType.person,
        );
      },
    );
  }

  Future<List<Movie>> fetchFavoriteAndNotWatchedMovies(
    String locale,
    int? maxLength,
  ) async {
    return ConnectivityHelper.connectivity<List<Movie>>(
      onConnectionYes: () async {
        final ids = await _accountApiClient.fetchFavoriteAndNotWatchedMovies();
        final movies = <Movie>[];
        final length = maxLength != null && maxLength < ids.length
            ? maxLength
            : ids.length;
        for (var i = 0; i < length; i++) {
          await Future.delayed(Duration.zero);
          final response =
              await _searchApiClient.findById(id: ids[i], locale: locale);
          final movie = response.movieResults.first;
          movies.add(movie);
          await Future.delayed(Duration.zero);
          _addMovieToDatabaseAndCheckUpdates(
              locale, movie, ViewFavoriteType.favoriteAndNotWatched);
        }
        if (maxLength == null || maxLength > ids.length) {
          _deleteOldMediaFromDB(
              movies, MediaType.movie, ViewFavoriteType.favoriteAndNotWatched);
        }
        return movies;
      },
      onConnectionNo: () async {
        return await _fetchMappedMediaFromDB<Movie>(
          MediaType.movie,
          ViewFavoriteType.favoriteAndNotWatched,
        );
      },
    );
  }

  Future<List<TvShow>> fetchFavoriteAndNotWatchedTvShows(
    String locale,
    int? maxLength,
  ) async {
    return ConnectivityHelper.connectivity<List<TvShow>>(
      onConnectionYes: () async {
        final ids = await _accountApiClient.fetchFavoriteAndNotWatchedTvShows();
        final tvShows = <TvShow>[];
        final length = maxLength != null && maxLength < ids.length
            ? maxLength
            : ids.length;
        for (var i = 0; i < length; i++) {
          await Future.delayed(Duration.zero);
          final response =
              await _searchApiClient.findById(id: ids[i], locale: locale);
          final tvShow = response.tvResults.first;
          tvShows.add(tvShow);
          await Future.delayed(Duration.zero);
          _addTvShowToDatabaseAndCheckUpdates(
              locale, tvShow, ViewFavoriteType.favoriteAndNotWatched);
        }
        if (maxLength == null || maxLength > ids.length) {
          _deleteOldMediaFromDB(
              tvShows, MediaType.tv, ViewFavoriteType.favoriteAndNotWatched);
        }
        return tvShows;
      },
      onConnectionNo: () async {
        return await _fetchMappedMediaFromDB<TvShow>(
          MediaType.tv,
          ViewFavoriteType.favoriteAndNotWatched,
        );
      },
    );
  }

  Future<void> _addMovieToDatabaseAndCheckUpdates(
    String locale,
    Movie movie,
    ViewFavoriteType type,
  ) async {
    try {
      MovieDetails? movieFromDB;
      switch (type) {
        case ViewFavoriteType.favorite:
          movieFromDB =
              (await database?.appDatabaseDao.fetchFavoriteMovie(movie.id!))
                  ?.data;
          break;
        case ViewFavoriteType.favoriteAndNotWatched:
          movieFromDB = (await database?.appDatabaseDao
                  .fetchFavoriteAndNotWatchedMovie(movie.id!))
              ?.data;
          break;
        case ViewFavoriteType.watched:
          movieFromDB =
              (await database?.appDatabaseDao.fetchWatchedMovie(movie.id!))
                  ?.data;
          break;
      }
      if (movieFromDB == null) {
        final movieDetails = await _movieApiClient.fetchMovieDetails(
          locale: locale,
          movieId: movie.id!,
        );
        await _insertMovieToDB(movieDetails, type);
        return;
      } else {
        return;
      }
    } catch (e) {
    }
    final movieDetails = await _movieApiClient.fetchMovieDetails(
      locale: locale,
      movieId: movie.id!,
    );
    await _insertMovieToDB(movieDetails, type);
  }

  Future<void> _insertMovieToDB(
      MovieDetails movieDetails, ViewFavoriteType type) async {
    await Future.delayed(Duration.zero);
    await database?.appDatabaseDao.insertMovie(movieDetails, type);
  }

  Future<void> _addTvShowToDatabaseAndCheckUpdates(
    String locale,
    TvShow tvShow,
    ViewFavoriteType type,
  ) async {
    try {
      TvShowDetails? tvShowFromDB;
      switch (type) {
        case ViewFavoriteType.favorite:
          tvShowFromDB =
              (await database?.appDatabaseDao.fetchFavoriteTvShow(tvShow.id!))
                  ?.data;
          break;
        case ViewFavoriteType.favoriteAndNotWatched:
          tvShowFromDB = (await database?.appDatabaseDao
                  .fetchFavoriteAndNotWatchedTvShow(tvShow.id!))
              ?.data;
          break;
        case ViewFavoriteType.watched:
          tvShowFromDB =
              (await database?.appDatabaseDao.fetchWatchedTvShow(tvShow.id!))
                  ?.data;
          break;
      }
      if (tvShowFromDB == null) {
        final tvShowDetails = await _tvShowApiClient.fetchTvShowDetails(
          locale: locale,
          tvShowId: tvShow.id!,
        );
        await _insertTvShowToDB(tvShowDetails, type);
        return;
      } else {
        return;
      }
    } catch (e) {
    }
    final tvShowDetails = await _tvShowApiClient.fetchTvShowDetails(
      locale: locale,
      tvShowId: tvShow.id!,
    );
    await _insertTvShowToDB(tvShowDetails, type);
  }

  Future<void> _insertTvShowToDB(
      TvShowDetails tvShowDetails, ViewFavoriteType type) async {
    await Future.delayed(Duration.zero);
    await database?.appDatabaseDao.insertTvShow(tvShowDetails, type);
  }

  Future<void> _addPersonToDatabaseAndCheckUpdates(
    String locale,
    Actor person,
    ViewFavoriteType type,
  ) async {
    try {
      ActorDetails? personFromDB;
      switch (type) {
        case ViewFavoriteType.favorite:
          personFromDB =
              (await database?.appDatabaseDao.fetchFavoritePerson(person.id!))
                  ?.data;
          break;
        case ViewFavoriteType.favoriteAndNotWatched:
          break;
        case ViewFavoriteType.watched:
          break;
      }
      if (personFromDB == null) {
        final personDetails = await _actorApiClient.fetchActorDetails(
          locale: locale,
          actorId: person.id!,
        );
        await _insertPersonToDB(personDetails, type);
        return;
      } else {
        return;
      }
    } catch (e) {
    }
    final personDetails = await _actorApiClient.fetchActorDetails(
      locale: locale,
      actorId: person.id!,
    );
    await _insertPersonToDB(personDetails, type);
  }

  Future<void> _insertPersonToDB(
      ActorDetails tvShowDetails, ViewFavoriteType type) async {
    await Future.delayed(Duration.zero);
    await database?.appDatabaseDao.insertPerson(tvShowDetails);
  }

  Future<List<T>> _fetchMappedMediaFromDB<T>(
    MediaType mediaType, [
    ViewFavoriteType viewFavoriteType = ViewFavoriteType.favorite,
  ]) async {
    List<dynamic> data;
    switch (mediaType) {
      case MediaType.movie:
        dynamic moviesFromDB;
        switch (viewFavoriteType) {
          case ViewFavoriteType.favorite:
            moviesFromDB = await database?.appDatabaseDao.fetchFavoriteMovies();
            break;
          case ViewFavoriteType.favoriteAndNotWatched:
            moviesFromDB = await database?.appDatabaseDao
                .fetchFavoriteAndNotWatchedMovies();
            break;
          case ViewFavoriteType.watched:
            moviesFromDB = await database?.appDatabaseDao.fetchWatchedMovies();
            break;
        }
        await Future.delayed(Duration.zero);
        data = moviesFromDB
            .map((movie) => Movie.fromJson(movie.data.toJson()))
            .toList();
        break;
      case MediaType.tv:
        dynamic tvShowsFromDB;
        switch (viewFavoriteType) {
          case ViewFavoriteType.favorite:
            tvShowsFromDB =
                await database?.appDatabaseDao.fetchFavoriteTvShows();
            break;
          case ViewFavoriteType.favoriteAndNotWatched:
            tvShowsFromDB = await database?.appDatabaseDao
                .fetchFavoriteAndNotWatchedTvShows();
            break;
          case ViewFavoriteType.watched:
            tvShowsFromDB =
                await database?.appDatabaseDao.fetchWatchedTvShows();
            break;
        }
        await Future.delayed(Duration.zero);
        data = tvShowsFromDB
            .map((movie) => TvShow.fromJson(movie.data.toJson()))
            .toList();
        break;
      case MediaType.person:
        final peopleFromDB =
            await database?.appDatabaseDao.fetchFavoritePeople();
        await Future.delayed(Duration.zero);
        data = peopleFromDB!
            .map((movie) => Actor.fromJson(movie.data.toJson()))
            .toList();
        break;
    }
    return data.cast<T>();
  }

  Future<List<T>> _fetchMediaFromDB<T>(
    MediaType mediaType, [
    ViewFavoriteType viewFavoriteType = ViewFavoriteType.favorite,
  ]) async {
    dynamic data;
    switch (mediaType) {
      case MediaType.movie:
        switch (viewFavoriteType) {
          case ViewFavoriteType.favorite:
            data = await database?.appDatabaseDao.fetchFavoriteMovies();
            break;
          case ViewFavoriteType.favoriteAndNotWatched:
            data = await database?.appDatabaseDao
                .fetchFavoriteAndNotWatchedMovies();
            break;
          case ViewFavoriteType.watched:
            data = await database?.appDatabaseDao.fetchWatchedMovies();
            break;
        }
        await Future.delayed(Duration.zero);
        break;
      case MediaType.tv:
        switch (viewFavoriteType) {
          case ViewFavoriteType.favorite:
            data = await database?.appDatabaseDao.fetchFavoriteTvShows();
            break;
          case ViewFavoriteType.favoriteAndNotWatched:
            data = await database?.appDatabaseDao
                .fetchFavoriteAndNotWatchedTvShows();
            break;
          case ViewFavoriteType.watched:
            data = await database?.appDatabaseDao.fetchWatchedTvShows();
        }
        await Future.delayed(Duration.zero);
        break;
      case MediaType.person:
        data = await database?.appDatabaseDao.fetchFavoritePeople();
        await Future.delayed(Duration.zero);
        break;
    }
    return data;
  }
}
