import 'package:json_annotation/json_annotation.dart';

part 'movie_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieCredits {
  final List<MovieCast> cast;
  final List<MovieCrew> crew;
  MovieCredits({
    required this.cast,
    required this.crew,
  });

  Map<String, dynamic> toJson() => _$MovieCreditsToJson(this);

  factory MovieCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieCast {
  final bool adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;
  MovieCast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  Map<String, dynamic> toJson() => _$MovieCastToJson(this);

  factory MovieCast.fromJson(Map<String, dynamic> json) => _$MovieCastFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieCrew {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;
  MovieCrew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  Map<String, dynamic> toJson() => _$MovieCrewToJson(this);

  factory MovieCrew.fromJson(Map<String, dynamic> json) => _$MovieCrewFromJson(json);
}
