import 'package:json_annotation/json_annotation.dart';

import '../date_parser.dart';

part 'episode_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class EpisodeDetails {
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;
  final List<Crew> crew;
  final int episodeNumber;
  final List<GuestStar> guestStars;
  final String name;
  final String overview;
  final int id;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  final Credits credits;
  final Videos videos;
  EpisodeDetails({
    required this.airDate,
    required this.crew,
    required this.episodeNumber,
    required this.guestStars,
    required this.name,
    required this.overview,
    required this.id,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
    required this.videos,
  });

  Map<String, dynamic> toJson() => _$EpisodeDetailsToJson(this);

  factory EpisodeDetails.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDetailsFromJson(json);

  EpisodeDetails copyWith({
    DateTime? airDate,
    List<Crew>? crew,
    int? episodeNumber,
    List<GuestStar>? guestStars,
    String? name,
    String? overview,
    int? id,
    String? productionCode,
    int? seasonNumber,
    String? stillPath,
    double? voteAverage,
    int? voteCount,
    Credits? credits,
    Videos? videos,
  }) {
    return EpisodeDetails(
      airDate: airDate ?? this.airDate,
      crew: crew ?? this.crew,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      guestStars: guestStars ?? this.guestStars,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      id: id ?? this.id,
      productionCode: productionCode ?? this.productionCode,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      stillPath: stillPath ?? this.stillPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      credits: credits ?? this.credits,
      videos: videos ?? this.videos,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  final String job;
  final String department;
  final String creditId;
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  Crew({
    required this.job,
    required this.department,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  Map<String, dynamic> toJson() => _$CrewToJson(this);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GuestStar {
  final String character;
  final String creditId;
  final int order;
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  GuestStar({
    required this.character,
    required this.creditId,
    required this.order,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  Map<String, dynamic> toJson() => _$GuestStarToJson(this);

  factory GuestStar.fromJson(Map<String, dynamic> json) =>
      _$GuestStarFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Credits {
  final List<Cast> cast;
  final List<Crew> crew;
  final List<GuestStar> guestStars;
  Credits({
    required this.cast,
    required this.crew,
    required this.guestStars,
  });

  Map<String, dynamic> toJson() => _$CreditsToJson(this);

  factory Credits.fromJson(Map<String, dynamic> json) =>
      _$CreditsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String character;
  final String creditId;
  final int order;
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });

  Map<String, dynamic> toJson() => _$CastToJson(this);

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Videos {
  final List<dynamic> results;
  Videos({
    required this.results,
  });

  Map<String, dynamic> toJson() => _$VideosToJson(this);

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);
}
