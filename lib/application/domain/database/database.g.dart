// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class FavoriteMovie extends DataClass implements Insertable<FavoriteMovie> {
  final int id;
  final String imdbId;
  final MovieDetails data;
  FavoriteMovie({required this.id, required this.imdbId, required this.data});
  factory FavoriteMovie.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteMovie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      imdbId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imdb_id'])!,
      data: $FavoriteMoviesTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imdb_id'] = Variable<String>(imdbId);
    {
      final converter = $FavoriteMoviesTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data)!);
    }
    return map;
  }

  FavoriteMoviesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteMoviesCompanion(
      id: Value(id),
      imdbId: Value(imdbId),
      data: Value(data),
    );
  }

  factory FavoriteMovie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteMovie(
      id: serializer.fromJson<int>(json['id']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      data: serializer.fromJson<MovieDetails>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imdbId': serializer.toJson<String>(imdbId),
      'data': serializer.toJson<MovieDetails>(data),
    };
  }

  FavoriteMovie copyWith({int? id, String? imdbId, MovieDetails? data}) =>
      FavoriteMovie(
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteMovie(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imdbId, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteMovie &&
          other.id == this.id &&
          other.imdbId == this.imdbId &&
          other.data == this.data);
}

class FavoriteMoviesCompanion extends UpdateCompanion<FavoriteMovie> {
  final Value<int> id;
  final Value<String> imdbId;
  final Value<MovieDetails> data;
  const FavoriteMoviesCompanion({
    this.id = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.data = const Value.absent(),
  });
  FavoriteMoviesCompanion.insert({
    required int id,
    required String imdbId,
    required MovieDetails data,
  })  : id = Value(id),
        imdbId = Value(imdbId),
        data = Value(data);
  static Insertable<FavoriteMovie> custom({
    Expression<int>? id,
    Expression<String>? imdbId,
    Expression<MovieDetails>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (data != null) 'data': data,
    });
  }

  FavoriteMoviesCompanion copyWith(
      {Value<int>? id, Value<String>? imdbId, Value<MovieDetails>? data}) {
    return FavoriteMoviesCompanion(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (data.present) {
      final converter = $FavoriteMoviesTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteMoviesCompanion(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $FavoriteMoviesTable extends FavoriteMovies
    with TableInfo<$FavoriteMoviesTable, FavoriteMovie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteMoviesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String?> imdbId = GeneratedColumn<String?>(
      'imdb_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<MovieDetails, String?> data =
      GeneratedColumn<String?>('data', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<MovieDetails>($FavoriteMoviesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, imdbId, data];
  @override
  String get aliasedName => _alias ?? 'favorite_movies';
  @override
  String get actualTableName => 'favorite_movies';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteMovie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, imdbId};
  @override
  FavoriteMovie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoriteMovie.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteMoviesTable createAlias(String alias) {
    return $FavoriteMoviesTable(attachedDatabase, alias);
  }

  static TypeConverter<MovieDetails, String> $converter0 =
      const MovieDetailsConverter();
}

class FavoriteTvShow extends DataClass implements Insertable<FavoriteTvShow> {
  final int id;
  final String imdbId;
  final TvShowDetails data;
  FavoriteTvShow({required this.id, required this.imdbId, required this.data});
  factory FavoriteTvShow.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteTvShow(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      imdbId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imdb_id'])!,
      data: $FavoriteTvShowsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imdb_id'] = Variable<String>(imdbId);
    {
      final converter = $FavoriteTvShowsTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data)!);
    }
    return map;
  }

  FavoriteTvShowsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteTvShowsCompanion(
      id: Value(id),
      imdbId: Value(imdbId),
      data: Value(data),
    );
  }

  factory FavoriteTvShow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteTvShow(
      id: serializer.fromJson<int>(json['id']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      data: serializer.fromJson<TvShowDetails>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imdbId': serializer.toJson<String>(imdbId),
      'data': serializer.toJson<TvShowDetails>(data),
    };
  }

  FavoriteTvShow copyWith({int? id, String? imdbId, TvShowDetails? data}) =>
      FavoriteTvShow(
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteTvShow(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imdbId, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteTvShow &&
          other.id == this.id &&
          other.imdbId == this.imdbId &&
          other.data == this.data);
}

class FavoriteTvShowsCompanion extends UpdateCompanion<FavoriteTvShow> {
  final Value<int> id;
  final Value<String> imdbId;
  final Value<TvShowDetails> data;
  const FavoriteTvShowsCompanion({
    this.id = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.data = const Value.absent(),
  });
  FavoriteTvShowsCompanion.insert({
    required int id,
    required String imdbId,
    required TvShowDetails data,
  })  : id = Value(id),
        imdbId = Value(imdbId),
        data = Value(data);
  static Insertable<FavoriteTvShow> custom({
    Expression<int>? id,
    Expression<String>? imdbId,
    Expression<TvShowDetails>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (data != null) 'data': data,
    });
  }

  FavoriteTvShowsCompanion copyWith(
      {Value<int>? id, Value<String>? imdbId, Value<TvShowDetails>? data}) {
    return FavoriteTvShowsCompanion(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (data.present) {
      final converter = $FavoriteTvShowsTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTvShowsCompanion(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $FavoriteTvShowsTable extends FavoriteTvShows
    with TableInfo<$FavoriteTvShowsTable, FavoriteTvShow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTvShowsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String?> imdbId = GeneratedColumn<String?>(
      'imdb_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<TvShowDetails, String?> data =
      GeneratedColumn<String?>('data', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<TvShowDetails>($FavoriteTvShowsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, imdbId, data];
  @override
  String get aliasedName => _alias ?? 'favorite_tv_shows';
  @override
  String get actualTableName => 'favorite_tv_shows';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteTvShow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, imdbId};
  @override
  FavoriteTvShow map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoriteTvShow.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteTvShowsTable createAlias(String alias) {
    return $FavoriteTvShowsTable(attachedDatabase, alias);
  }

  static TypeConverter<TvShowDetails, String> $converter0 =
      const TvShowDetailsConverter();
}

class FavoritePeopleData extends DataClass
    implements Insertable<FavoritePeopleData> {
  final int id;
  final String imdbId;
  final ActorDetails data;
  FavoritePeopleData(
      {required this.id, required this.imdbId, required this.data});
  factory FavoritePeopleData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoritePeopleData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      imdbId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imdb_id'])!,
      data: $FavoritePeopleTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imdb_id'] = Variable<String>(imdbId);
    {
      final converter = $FavoritePeopleTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data)!);
    }
    return map;
  }

  FavoritePeopleCompanion toCompanion(bool nullToAbsent) {
    return FavoritePeopleCompanion(
      id: Value(id),
      imdbId: Value(imdbId),
      data: Value(data),
    );
  }

  factory FavoritePeopleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePeopleData(
      id: serializer.fromJson<int>(json['id']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      data: serializer.fromJson<ActorDetails>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imdbId': serializer.toJson<String>(imdbId),
      'data': serializer.toJson<ActorDetails>(data),
    };
  }

  FavoritePeopleData copyWith({int? id, String? imdbId, ActorDetails? data}) =>
      FavoritePeopleData(
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('FavoritePeopleData(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imdbId, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePeopleData &&
          other.id == this.id &&
          other.imdbId == this.imdbId &&
          other.data == this.data);
}

class FavoritePeopleCompanion extends UpdateCompanion<FavoritePeopleData> {
  final Value<int> id;
  final Value<String> imdbId;
  final Value<ActorDetails> data;
  const FavoritePeopleCompanion({
    this.id = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.data = const Value.absent(),
  });
  FavoritePeopleCompanion.insert({
    required int id,
    required String imdbId,
    required ActorDetails data,
  })  : id = Value(id),
        imdbId = Value(imdbId),
        data = Value(data);
  static Insertable<FavoritePeopleData> custom({
    Expression<int>? id,
    Expression<String>? imdbId,
    Expression<ActorDetails>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (data != null) 'data': data,
    });
  }

  FavoritePeopleCompanion copyWith(
      {Value<int>? id, Value<String>? imdbId, Value<ActorDetails>? data}) {
    return FavoritePeopleCompanion(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (data.present) {
      final converter = $FavoritePeopleTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePeopleCompanion(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $FavoritePeopleTable extends FavoritePeople
    with TableInfo<$FavoritePeopleTable, FavoritePeopleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePeopleTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String?> imdbId = GeneratedColumn<String?>(
      'imdb_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<ActorDetails, String?> data =
      GeneratedColumn<String?>('data', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<ActorDetails>($FavoritePeopleTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, imdbId, data];
  @override
  String get aliasedName => _alias ?? 'favorite_people';
  @override
  String get actualTableName => 'favorite_people';
  @override
  VerificationContext validateIntegrity(Insertable<FavoritePeopleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, imdbId};
  @override
  FavoritePeopleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoritePeopleData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritePeopleTable createAlias(String alias) {
    return $FavoritePeopleTable(attachedDatabase, alias);
  }

  static TypeConverter<ActorDetails, String> $converter0 =
      const ActorDetailsConverter();
}

class WatchedMovie extends DataClass implements Insertable<WatchedMovie> {
  final int id;
  final String imdbId;
  final MovieDetails data;
  WatchedMovie({required this.id, required this.imdbId, required this.data});
  factory WatchedMovie.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WatchedMovie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      imdbId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imdb_id'])!,
      data: $WatchedMoviesTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imdb_id'] = Variable<String>(imdbId);
    {
      final converter = $WatchedMoviesTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data)!);
    }
    return map;
  }

  WatchedMoviesCompanion toCompanion(bool nullToAbsent) {
    return WatchedMoviesCompanion(
      id: Value(id),
      imdbId: Value(imdbId),
      data: Value(data),
    );
  }

  factory WatchedMovie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WatchedMovie(
      id: serializer.fromJson<int>(json['id']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      data: serializer.fromJson<MovieDetails>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imdbId': serializer.toJson<String>(imdbId),
      'data': serializer.toJson<MovieDetails>(data),
    };
  }

  WatchedMovie copyWith({int? id, String? imdbId, MovieDetails? data}) =>
      WatchedMovie(
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('WatchedMovie(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imdbId, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchedMovie &&
          other.id == this.id &&
          other.imdbId == this.imdbId &&
          other.data == this.data);
}

class WatchedMoviesCompanion extends UpdateCompanion<WatchedMovie> {
  final Value<int> id;
  final Value<String> imdbId;
  final Value<MovieDetails> data;
  const WatchedMoviesCompanion({
    this.id = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.data = const Value.absent(),
  });
  WatchedMoviesCompanion.insert({
    required int id,
    required String imdbId,
    required MovieDetails data,
  })  : id = Value(id),
        imdbId = Value(imdbId),
        data = Value(data);
  static Insertable<WatchedMovie> custom({
    Expression<int>? id,
    Expression<String>? imdbId,
    Expression<MovieDetails>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (data != null) 'data': data,
    });
  }

  WatchedMoviesCompanion copyWith(
      {Value<int>? id, Value<String>? imdbId, Value<MovieDetails>? data}) {
    return WatchedMoviesCompanion(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (data.present) {
      final converter = $WatchedMoviesTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchedMoviesCompanion(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $WatchedMoviesTable extends WatchedMovies
    with TableInfo<$WatchedMoviesTable, WatchedMovie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WatchedMoviesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String?> imdbId = GeneratedColumn<String?>(
      'imdb_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<MovieDetails, String?> data =
      GeneratedColumn<String?>('data', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<MovieDetails>($WatchedMoviesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, imdbId, data];
  @override
  String get aliasedName => _alias ?? 'watched_movies';
  @override
  String get actualTableName => 'watched_movies';
  @override
  VerificationContext validateIntegrity(Insertable<WatchedMovie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, imdbId};
  @override
  WatchedMovie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WatchedMovie.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WatchedMoviesTable createAlias(String alias) {
    return $WatchedMoviesTable(attachedDatabase, alias);
  }

  static TypeConverter<MovieDetails, String> $converter0 =
      const MovieDetailsConverter();
}

class WatchedTvShow extends DataClass implements Insertable<WatchedTvShow> {
  final int id;
  final String imdbId;
  final TvShowDetails data;
  WatchedTvShow({required this.id, required this.imdbId, required this.data});
  factory WatchedTvShow.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WatchedTvShow(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      imdbId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imdb_id'])!,
      data: $WatchedTvShowsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imdb_id'] = Variable<String>(imdbId);
    {
      final converter = $WatchedTvShowsTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data)!);
    }
    return map;
  }

  WatchedTvShowsCompanion toCompanion(bool nullToAbsent) {
    return WatchedTvShowsCompanion(
      id: Value(id),
      imdbId: Value(imdbId),
      data: Value(data),
    );
  }

  factory WatchedTvShow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WatchedTvShow(
      id: serializer.fromJson<int>(json['id']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      data: serializer.fromJson<TvShowDetails>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imdbId': serializer.toJson<String>(imdbId),
      'data': serializer.toJson<TvShowDetails>(data),
    };
  }

  WatchedTvShow copyWith({int? id, String? imdbId, TvShowDetails? data}) =>
      WatchedTvShow(
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('WatchedTvShow(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imdbId, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchedTvShow &&
          other.id == this.id &&
          other.imdbId == this.imdbId &&
          other.data == this.data);
}

class WatchedTvShowsCompanion extends UpdateCompanion<WatchedTvShow> {
  final Value<int> id;
  final Value<String> imdbId;
  final Value<TvShowDetails> data;
  const WatchedTvShowsCompanion({
    this.id = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.data = const Value.absent(),
  });
  WatchedTvShowsCompanion.insert({
    required int id,
    required String imdbId,
    required TvShowDetails data,
  })  : id = Value(id),
        imdbId = Value(imdbId),
        data = Value(data);
  static Insertable<WatchedTvShow> custom({
    Expression<int>? id,
    Expression<String>? imdbId,
    Expression<TvShowDetails>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (data != null) 'data': data,
    });
  }

  WatchedTvShowsCompanion copyWith(
      {Value<int>? id, Value<String>? imdbId, Value<TvShowDetails>? data}) {
    return WatchedTvShowsCompanion(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (data.present) {
      final converter = $WatchedTvShowsTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchedTvShowsCompanion(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $WatchedTvShowsTable extends WatchedTvShows
    with TableInfo<$WatchedTvShowsTable, WatchedTvShow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WatchedTvShowsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String?> imdbId = GeneratedColumn<String?>(
      'imdb_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<TvShowDetails, String?> data =
      GeneratedColumn<String?>('data', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<TvShowDetails>($WatchedTvShowsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, imdbId, data];
  @override
  String get aliasedName => _alias ?? 'watched_tv_shows';
  @override
  String get actualTableName => 'watched_tv_shows';
  @override
  VerificationContext validateIntegrity(Insertable<WatchedTvShow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, imdbId};
  @override
  WatchedTvShow map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WatchedTvShow.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WatchedTvShowsTable createAlias(String alias) {
    return $WatchedTvShowsTable(attachedDatabase, alias);
  }

  static TypeConverter<TvShowDetails, String> $converter0 =
      const TvShowDetailsConverter();
}

class FavoriteAndNotWatchedMovie extends DataClass
    implements Insertable<FavoriteAndNotWatchedMovie> {
  final int id;
  final String imdbId;
  final MovieDetails data;
  FavoriteAndNotWatchedMovie(
      {required this.id, required this.imdbId, required this.data});
  factory FavoriteAndNotWatchedMovie.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteAndNotWatchedMovie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      imdbId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imdb_id'])!,
      data: $FavoriteAndNotWatchedMoviesTable.$converter0.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}data']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imdb_id'] = Variable<String>(imdbId);
    {
      final converter = $FavoriteAndNotWatchedMoviesTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data)!);
    }
    return map;
  }

  FavoriteAndNotWatchedMoviesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteAndNotWatchedMoviesCompanion(
      id: Value(id),
      imdbId: Value(imdbId),
      data: Value(data),
    );
  }

  factory FavoriteAndNotWatchedMovie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteAndNotWatchedMovie(
      id: serializer.fromJson<int>(json['id']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      data: serializer.fromJson<MovieDetails>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imdbId': serializer.toJson<String>(imdbId),
      'data': serializer.toJson<MovieDetails>(data),
    };
  }

  FavoriteAndNotWatchedMovie copyWith(
          {int? id, String? imdbId, MovieDetails? data}) =>
      FavoriteAndNotWatchedMovie(
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteAndNotWatchedMovie(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imdbId, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteAndNotWatchedMovie &&
          other.id == this.id &&
          other.imdbId == this.imdbId &&
          other.data == this.data);
}

class FavoriteAndNotWatchedMoviesCompanion
    extends UpdateCompanion<FavoriteAndNotWatchedMovie> {
  final Value<int> id;
  final Value<String> imdbId;
  final Value<MovieDetails> data;
  const FavoriteAndNotWatchedMoviesCompanion({
    this.id = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.data = const Value.absent(),
  });
  FavoriteAndNotWatchedMoviesCompanion.insert({
    required int id,
    required String imdbId,
    required MovieDetails data,
  })  : id = Value(id),
        imdbId = Value(imdbId),
        data = Value(data);
  static Insertable<FavoriteAndNotWatchedMovie> custom({
    Expression<int>? id,
    Expression<String>? imdbId,
    Expression<MovieDetails>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (data != null) 'data': data,
    });
  }

  FavoriteAndNotWatchedMoviesCompanion copyWith(
      {Value<int>? id, Value<String>? imdbId, Value<MovieDetails>? data}) {
    return FavoriteAndNotWatchedMoviesCompanion(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (data.present) {
      final converter = $FavoriteAndNotWatchedMoviesTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteAndNotWatchedMoviesCompanion(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $FavoriteAndNotWatchedMoviesTable extends FavoriteAndNotWatchedMovies
    with
        TableInfo<$FavoriteAndNotWatchedMoviesTable,
            FavoriteAndNotWatchedMovie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteAndNotWatchedMoviesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String?> imdbId = GeneratedColumn<String?>(
      'imdb_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<MovieDetails, String?> data =
      GeneratedColumn<String?>('data', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<MovieDetails>(
              $FavoriteAndNotWatchedMoviesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, imdbId, data];
  @override
  String get aliasedName => _alias ?? 'favorite_and_not_watched_movies';
  @override
  String get actualTableName => 'favorite_and_not_watched_movies';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavoriteAndNotWatchedMovie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, imdbId};
  @override
  FavoriteAndNotWatchedMovie map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return FavoriteAndNotWatchedMovie.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteAndNotWatchedMoviesTable createAlias(String alias) {
    return $FavoriteAndNotWatchedMoviesTable(attachedDatabase, alias);
  }

  static TypeConverter<MovieDetails, String> $converter0 =
      const MovieDetailsConverter();
}

class FavoriteAndNotWatchedTvShow extends DataClass
    implements Insertable<FavoriteAndNotWatchedTvShow> {
  final int id;
  final String imdbId;
  final TvShowDetails data;
  FavoriteAndNotWatchedTvShow(
      {required this.id, required this.imdbId, required this.data});
  factory FavoriteAndNotWatchedTvShow.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteAndNotWatchedTvShow(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      imdbId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imdb_id'])!,
      data: $FavoriteAndNotWatchedTvShowsTable.$converter0.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}data']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imdb_id'] = Variable<String>(imdbId);
    {
      final converter = $FavoriteAndNotWatchedTvShowsTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data)!);
    }
    return map;
  }

  FavoriteAndNotWatchedTvShowsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteAndNotWatchedTvShowsCompanion(
      id: Value(id),
      imdbId: Value(imdbId),
      data: Value(data),
    );
  }

  factory FavoriteAndNotWatchedTvShow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteAndNotWatchedTvShow(
      id: serializer.fromJson<int>(json['id']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      data: serializer.fromJson<TvShowDetails>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imdbId': serializer.toJson<String>(imdbId),
      'data': serializer.toJson<TvShowDetails>(data),
    };
  }

  FavoriteAndNotWatchedTvShow copyWith(
          {int? id, String? imdbId, TvShowDetails? data}) =>
      FavoriteAndNotWatchedTvShow(
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteAndNotWatchedTvShow(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imdbId, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteAndNotWatchedTvShow &&
          other.id == this.id &&
          other.imdbId == this.imdbId &&
          other.data == this.data);
}

class FavoriteAndNotWatchedTvShowsCompanion
    extends UpdateCompanion<FavoriteAndNotWatchedTvShow> {
  final Value<int> id;
  final Value<String> imdbId;
  final Value<TvShowDetails> data;
  const FavoriteAndNotWatchedTvShowsCompanion({
    this.id = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.data = const Value.absent(),
  });
  FavoriteAndNotWatchedTvShowsCompanion.insert({
    required int id,
    required String imdbId,
    required TvShowDetails data,
  })  : id = Value(id),
        imdbId = Value(imdbId),
        data = Value(data);
  static Insertable<FavoriteAndNotWatchedTvShow> custom({
    Expression<int>? id,
    Expression<String>? imdbId,
    Expression<TvShowDetails>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (data != null) 'data': data,
    });
  }

  FavoriteAndNotWatchedTvShowsCompanion copyWith(
      {Value<int>? id, Value<String>? imdbId, Value<TvShowDetails>? data}) {
    return FavoriteAndNotWatchedTvShowsCompanion(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (data.present) {
      final converter = $FavoriteAndNotWatchedTvShowsTable.$converter0;
      map['data'] = Variable<String>(converter.mapToSql(data.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteAndNotWatchedTvShowsCompanion(')
          ..write('id: $id, ')
          ..write('imdbId: $imdbId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $FavoriteAndNotWatchedTvShowsTable extends FavoriteAndNotWatchedTvShows
    with
        TableInfo<$FavoriteAndNotWatchedTvShowsTable,
            FavoriteAndNotWatchedTvShow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteAndNotWatchedTvShowsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String?> imdbId = GeneratedColumn<String?>(
      'imdb_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<TvShowDetails, String?> data =
      GeneratedColumn<String?>('data', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<TvShowDetails>(
              $FavoriteAndNotWatchedTvShowsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, imdbId, data];
  @override
  String get aliasedName => _alias ?? 'favorite_and_not_watched_tv_shows';
  @override
  String get actualTableName => 'favorite_and_not_watched_tv_shows';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavoriteAndNotWatchedTvShow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, imdbId};
  @override
  FavoriteAndNotWatchedTvShow map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return FavoriteAndNotWatchedTvShow.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteAndNotWatchedTvShowsTable createAlias(String alias) {
    return $FavoriteAndNotWatchedTvShowsTable(attachedDatabase, alias);
  }

  static TypeConverter<TvShowDetails, String> $converter0 =
      const TvShowDetailsConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$AppDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $FavoriteMoviesTable favoriteMovies = $FavoriteMoviesTable(this);
  late final $FavoriteTvShowsTable favoriteTvShows =
      $FavoriteTvShowsTable(this);
  late final $FavoritePeopleTable favoritePeople = $FavoritePeopleTable(this);
  late final $WatchedMoviesTable watchedMovies = $WatchedMoviesTable(this);
  late final $WatchedTvShowsTable watchedTvShows = $WatchedTvShowsTable(this);
  late final $FavoriteAndNotWatchedMoviesTable favoriteAndNotWatchedMovies =
      $FavoriteAndNotWatchedMoviesTable(this);
  late final $FavoriteAndNotWatchedTvShowsTable favoriteAndNotWatchedTvShows =
      $FavoriteAndNotWatchedTvShowsTable(this);
  late final AppDatabaseDao appDatabaseDao =
      AppDatabaseDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        favoriteMovies,
        favoriteTvShows,
        favoritePeople,
        watchedMovies,
        watchedTvShows,
        favoriteAndNotWatchedMovies,
        favoriteAndNotWatchedTvShows
      ];
}
