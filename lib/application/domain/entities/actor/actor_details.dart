import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';

import '../date_parser.dart';
import 'media_type_parser.dart';

part 'actor_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ActorDetails {
  final bool? adult;
  final List<String> alsoKnownAs;
  final String? biography;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? birthday;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? deathday;
  final int gender;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String? knownForDepartment;
  final String name;
  final String? placeOfBirth;
  final double popularity;
  final String? profilePath;
  final CombinedCredits combinedCredits;
  final ExternalIds externalIds;
  ActorDetails({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
    required this.combinedCredits,
    required this.externalIds,
  });

  Map<String, dynamic> toJson() => _$ActorDetailsToJson(this);

  factory ActorDetails.fromJson(Map<String, dynamic> json) =>
      _$ActorDetailsFromJson(json);

  ActorDetails copyWith({
    bool? adult,
    List<String>? alsoKnownAs,
    String? biography,
    DateTime? birthday,
    DateTime? deathday,
    int? gender,
    String? homepage,
    int? id,
    String? imdbId,
    String? knownForDepartment,
    String? name,
    String? placeOfBirth,
    double? popularity,
    String? profilePath,
    CombinedCredits? combinedCredits,
    ExternalIds? externalIds,
  }) {
    return ActorDetails(
      adult: adult ?? this.adult,
      alsoKnownAs: alsoKnownAs ?? this.alsoKnownAs,
      biography: biography ?? this.biography,
      birthday: birthday ?? this.birthday,
      deathday: deathday ?? this.deathday,
      gender: gender ?? this.gender,
      homepage: homepage ?? this.homepage,
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
      combinedCredits: combinedCredits ?? this.combinedCredits,
      externalIds: externalIds ?? this.externalIds,
    );
  }
}

class ActorDetailsConverter extends drift.TypeConverter<ActorDetails, String> {
  const ActorDetailsConverter();
  @override
  ActorDetails? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return ActorDetails.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String? mapToSql(ActorDetails? value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CombinedCredits {
  List<Cast> cast;
  List<Crew> crew;
  CombinedCredits({
    required this.cast,
    required this.crew,
  });

  Map<String, dynamic> toJson() => _$CombinedCreditsToJson(this);

  factory CombinedCredits.fromJson(Map<String, dynamic> json) =>
      _$CombinedCreditsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  final double voteAverage;
  final String? overview;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final String? title;
  final bool? adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int? voteCount;
  final String? originalLanguage;
  final String? originalTitle;
  final String? posterPath;
  final bool? video;
  final int id;
  final double? popularity;
  final String? character;
  final String? creditId;
  final int? order;
  @JsonKey(fromJson: parseMediaTypeFromString)
  final MediaType? mediaType;
  Cast({
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
    required this.title,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.voteCount,
    required this.originalLanguage,
    required this.originalTitle,
    required this.posterPath,
    required this.video,
    required this.id,
    required this.popularity,
    required this.character,
    required this.creditId,
    required this.order,
    required this.mediaType,
  });

  Map<String, dynamic> toJson() => _$CastToJson(this);

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  final bool? adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double voteAverage;
  final int? voteCount;
  final double? popularity;
  final String? creditId;
  final String? department;
  final String? job;
  @JsonKey(fromJson: parseMediaTypeFromString)
  final MediaType? mediaType;
  Crew({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.creditId,
    required this.department,
    required this.job,
    required this.mediaType,
  });

  Map<String, dynamic> toJson() => _$CrewToJson(this);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ExternalIds {
  final String? freebaseMid;
  final String? freebaseId;
  final String? imdbId;
  final int? tvrageId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;
  ExternalIds({
    required this.freebaseMid,
    required this.freebaseId,
    required this.imdbId,
    required this.tvrageId,
    required this.facebookId,
    required this.instagramId,
    required this.twitterId,
  });

  Map<String, dynamic> toJson() => _$ExternalIdsToJson(this);

  factory ExternalIds.fromJson(Map<String, dynamic> json) =>
      _$ExternalIdsFromJson(json);
}
