import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:movie_night/application/domain/database/dao.dart';
import 'package:movie_night/application/domain/database/tables.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../entities/actor/actor_details.dart';
import '../entities/movie/movie_details.dart';
import '../entities/tv_shows/tv_show_details.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  FavoriteMovies,
  FavoriteTvShows,
  FavoritePeople,
  WatchedMovies,
  WatchedTvShows,
  FavoriteAndNotWatchedMovies,
  FavoriteAndNotWatchedTvShows
], daos: [
  AppDatabaseDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.connect(DatabaseConnection connection)
      : super.connect(connection);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'movie_night.db'));
    return NativeDatabase(file, logStatements: true);
  });
}

Future<DriftIsolate> createDriftIsolate() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final path = p.join(dbFolder.path, 'movie_night.db');
  final receivePort = ReceivePort();
  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  // _startBackground will send the DriftIsolate to this ReceivePort
  return await receivePort.first as DriftIsolate;
}

void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  // inform the starting isolate about this, so that it can call .connect()
  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

DatabaseConnection createDriftIsolateAndConnect() {
  return DatabaseConnection.delayed(() async {
    final isolate = await createDriftIsolate();
    return await isolate.connect();
  }());
}