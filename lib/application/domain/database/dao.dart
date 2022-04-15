import 'package:drift/drift.dart';
import 'package:movie_night/application/domain/database/database.dart';
import 'package:movie_night/application/domain/database/tables.dart';
import 'package:movie_night/application/domain/entities/actor/actor_details.dart';
import 'package:movie_night/application/domain/entities/movie/movie_details.dart';
import 'package:movie_night/application/ui/screens/view_favorite/view_favorite_view_model.dart';

import '../entities/tv_shows/tv_show_details.dart';

part 'dao.g.dart';

@DriftAccessor(tables: [
  FavoriteMovies,
  FavoriteTvShows,
  FavoritePeople,
  WatchedMovies,
  WatchedTvShows,
  FavoriteAndNotWatchedMovies,
  FavoriteAndNotWatchedTvShows,
])
class AppDatabaseDao extends DatabaseAccessor<AppDatabase>
    with _$AppDatabaseDaoMixin {
  final AppDatabase db;

  AppDatabaseDao(this.db) : super(db);

  Future<List<FavoriteMovie>> fetchFavoriteMovies() =>
      select(favoriteMovies).get();
  Future<FavoriteMovie> fetchFavoriteMovie(int id) =>
      (select(favoriteMovies)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<int> deleteFavoriteMovie(String id) =>
      (delete(favoriteMovies)..where((tbl) => tbl.imdbId.equals(id))).go();
  Future<List<FavoriteTvShow>> fetchFavoriteTvShows() =>
      select(favoriteTvShows).get();
  Future<FavoriteTvShow> fetchFavoriteTvShow(int id) =>
      (select(favoriteTvShows)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<int> deleteFavoriteTvShow(String id) =>
      (delete(favoriteTvShows)..where((tbl) => tbl.imdbId.equals(id))).go();
  Future<List<FavoritePeopleData>> fetchFavoritePeople() =>
      select(favoritePeople).get();
  Future<FavoritePeopleData> fetchFavoritePerson(int id) =>
      (select(favoritePeople)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<int> deleteFavoritePerson(String id) =>
      (delete(favoritePeople)..where((tbl) => tbl.imdbId.equals(id))).go();
  Future<List<WatchedMovie>> fetchWatchedMovies() =>
      select(watchedMovies).get();
  Future<WatchedMovie> fetchWatchedMovie(int id) =>
      (select(watchedMovies)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<int> deleteWatchedMovie(String id) =>
      (delete(watchedMovies)..where((tbl) => tbl.imdbId.equals(id))).go();
  Future<List<WatchedTvShow>> fetchWatchedTvShows() =>
      select(watchedTvShows).get();
  Future<WatchedTvShow> fetchWatchedTvShow(int id) =>
      (select(watchedTvShows)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<int> deleteWatchedTvShow(String id) =>
      (delete(watchedTvShows)..where((tbl) => tbl.imdbId.equals(id))).go();
  Future<List<FavoriteAndNotWatchedMovie>> fetchFavoriteAndNotWatchedMovies() =>
      select(favoriteAndNotWatchedMovies).get();
  Future<FavoriteAndNotWatchedMovie> fetchFavoriteAndNotWatchedMovie(int id) =>
      (select(favoriteAndNotWatchedMovies)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
  Future<int> deleteFavoriteAndNotWatchedMovie(String id) =>
      (delete(favoriteAndNotWatchedMovies)
            ..where((tbl) => tbl.imdbId.equals(id)))
          .go();
  Future<List<FavoriteAndNotWatchedTvShow>>
      fetchFavoriteAndNotWatchedTvShows() =>
          select(favoriteAndNotWatchedTvShows).get();
  Future<FavoriteAndNotWatchedTvShow> fetchFavoriteAndNotWatchedTvShow(
          int id) =>
      (select(favoriteAndNotWatchedTvShows)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
  Future<int> deleteFavoriteAndNotWatchedTvShow(String id) =>
      (delete(favoriteAndNotWatchedTvShows)..where((tbl) => tbl.imdbId.equals(id)))
          .go();
  Future insertMovie(MovieDetails movieDetails, ViewFavoriteType type) {
    return transaction(() async {
      switch (type) {
        case ViewFavoriteType.favorite:
          final movie = FavoriteMoviesCompanion(
              id: Value(movieDetails.id!),
              imdbId: Value(movieDetails.externalIds!.imdbId!),
              data: Value(movieDetails));
          await into(favoriteMovies)
              .insert(movie, mode: InsertMode.insertOrReplace);
          break;
        case ViewFavoriteType.favoriteAndNotWatched:
          final movie = FavoriteAndNotWatchedMoviesCompanion(
              id: Value(movieDetails.id!),
              imdbId: Value(movieDetails.externalIds!.imdbId!),
              data: Value(movieDetails));
          await into(favoriteAndNotWatchedMovies)
              .insert(movie, mode: InsertMode.insertOrReplace);
          break;
        case ViewFavoriteType.watched:
          final movie = WatchedMoviesCompanion(
              id: Value(movieDetails.id!),
              imdbId: Value(movieDetails.externalIds!.imdbId!),
              data: Value(movieDetails));
          await into(watchedMovies)
              .insert(movie, mode: InsertMode.insertOrReplace);
          break;
      }
    });
  }

  Future insertTvShow(TvShowDetails tvShowDetails, ViewFavoriteType type) {
    return transaction(() async {
      switch (type) {
        case ViewFavoriteType.favorite:
          final tvShow = FavoriteTvShowsCompanion(
              id: Value(tvShowDetails.id),
              imdbId: Value(tvShowDetails.externalIds.imdbId!),
              data: Value(tvShowDetails));
          await into(favoriteTvShows)
              .insert(tvShow, mode: InsertMode.insertOrReplace);
          break;
        case ViewFavoriteType.favoriteAndNotWatched:
          final tvShow = FavoriteAndNotWatchedTvShowsCompanion(
              id: Value(tvShowDetails.id),
              imdbId: Value(tvShowDetails.externalIds.imdbId!),
              data: Value(tvShowDetails));
          await into(favoriteAndNotWatchedTvShows)
              .insert(tvShow, mode: InsertMode.insertOrReplace);
          break;
        case ViewFavoriteType.watched:
          final tvShow = WatchedTvShowsCompanion(
              id: Value(tvShowDetails.id),
              imdbId: Value(tvShowDetails.externalIds.imdbId!),
              data: Value(tvShowDetails));
          await into(watchedTvShows)
              .insert(tvShow, mode: InsertMode.insertOrReplace);
          break;
      }
    });
  }

  Future insertPerson(ActorDetails personDetails) {
    return transaction(() async {
      final person = FavoritePeopleCompanion(
          id: Value(personDetails.id),
          imdbId: Value(personDetails.externalIds.imdbId!),
          data: Value(personDetails));
      await into(favoritePeople)
          .insert(person, mode: InsertMode.insertOrReplace);
    });
  }
}
