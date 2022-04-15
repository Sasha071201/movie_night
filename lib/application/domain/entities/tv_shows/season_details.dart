import 'package:json_annotation/json_annotation.dart';

import '../date_parser.dart';

part 'season_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SeasonDetails {
  @JsonKey(name: '_id')
  final String? id1;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;
  final List<Episode>? episodes;
  final String? name;
  final String? overview;
  @JsonKey(name: 'id')
  final int id2;
  final String? posterPath;
  final int seasonNumber;
  final AggregateCredits aggregateCredits;
  final Videos videos; 
  SeasonDetails({
    required this.id1,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id2,
    required this.posterPath,
    required this.seasonNumber,
    required this.aggregateCredits,
    required this.videos,
  });

  Map<String, dynamic> toJson() => _$SeasonDetailsToJson(this);

  factory SeasonDetails.fromJson(Map<String, dynamic> json) =>
      _$SeasonDetailsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Episode {
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;
  final int episodeNumber;
  final List<EpisodeCrew> crew;
  final List<GuestStar> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int voteCount;
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EpisodeCrew {
  final String job;
  final String? department;
  final String creditId;
  final bool? adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  EpisodeCrew({
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

  Map<String, dynamic> toJson() => _$EpisodeCrewToJson(this);

  factory EpisodeCrew.fromJson(Map<String, dynamic> json) =>
      _$EpisodeCrewFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GuestStar {
  final String character;
  final String creditId;
  final int order;
  final bool? adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
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
class AggregateCredits {
  final List<Cast> cast;
  final List<Crew> crew;
  AggregateCredits({
    required this.cast,
    required this.crew,
  });

  Map<String, dynamic> toJson() => _$AggregateCreditsToJson(this);

  factory AggregateCredits.fromJson(Map<String, dynamic> json) =>
      _$AggregateCreditsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  final bool? adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<Role> roles;
  final int totalEpisodeCount;
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
    required this.roles,
    required this.totalEpisodeCount,
    required this.order,
  });

  Map<String, dynamic> toJson() => _$CastToJson(this);

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Role {
  final String creditId;
  final String character;
  final int episodeCount;
  Role({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  final bool? adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<Job> jobs;
  final String? department;
  final int totalEpisodeCount;
  Crew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.jobs,
    required this.department,
    required this.totalEpisodeCount,
  });

  Map<String, dynamic> toJson() => _$CrewToJson(this);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Job {
  final String creditId;
  final String job;
  final int episodeCount;
  Job({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  Map<String, dynamic> toJson() => _$JobToJson(this);

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
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
