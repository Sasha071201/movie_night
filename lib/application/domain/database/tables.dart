import 'package:drift/drift.dart';

import '../entities/actor/actor_details.dart';
import '../entities/movie/movie_details.dart';
import '../entities/tv_shows/tv_show_details.dart';

class FavoriteMovies extends Table {
  IntColumn get id => integer()();
  TextColumn get imdbId => text()();
  TextColumn get data => text().map(const MovieDetailsConverter())();

  @override
  Set<Column>? get primaryKey => {id, imdbId};
}

class FavoriteTvShows extends Table {
  IntColumn get id => integer()();
  TextColumn get imdbId => text()();
  TextColumn get data => text().map(const TvShowDetailsConverter())();

  @override
  Set<Column>? get primaryKey => {id, imdbId};
}

class WatchedMovies extends Table {
  IntColumn get id => integer()();
  TextColumn get imdbId => text()();
  TextColumn get data => text().map(const MovieDetailsConverter())();

  @override
  Set<Column>? get primaryKey => {id, imdbId};
}

class WatchedTvShows extends Table {
  IntColumn get id => integer()();
  TextColumn get imdbId => text()();
  TextColumn get data => text().map(const TvShowDetailsConverter())();

  @override
  Set<Column>? get primaryKey => {id, imdbId};
}

class FavoriteAndNotWatchedMovies extends Table {
  IntColumn get id => integer()();
  TextColumn get imdbId => text()();
  TextColumn get data => text().map(const MovieDetailsConverter())();

  @override
  Set<Column>? get primaryKey => {id, imdbId};
}

class FavoriteAndNotWatchedTvShows extends Table {
  IntColumn get id => integer()();
  TextColumn get imdbId => text()();
  TextColumn get data => text().map(const TvShowDetailsConverter())();

  @override
  Set<Column>? get primaryKey => {id, imdbId};
}

class FavoritePeople extends Table {
  IntColumn get id => integer()();
  TextColumn get imdbId => text()();
  TextColumn get data => text().map(const ActorDetailsConverter())();

  @override
  Set<Column>? get primaryKey => {id, imdbId};
}
