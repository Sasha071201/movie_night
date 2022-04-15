import 'package:json_annotation/json_annotation.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/entities/actor/media_type_parser.dart';

import '../date_parser.dart';
import 'actor.dart';

part 'popular_actors.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularActors {
  final int page;
  final List<Actor> results;
  final int totalPages;
  final int totalResults;
  PopularActors({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$PopularActorsToJson(this);

  factory PopularActors.fromJson(Map<String, dynamic> json) =>
      _$PopularActorsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class KnownFor {
  final bool? adult;
  final String? backdropPath;
  final List<double> genreIds;
  final double id;
  @JsonKey(fromJson: parseMediaTypeFromString)
  final MediaType? mediaType;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double voteAverage;
  final double voteCount;
  KnownFor({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toJson() => _$KnownForToJson(this);

  factory KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForFromJson(json);
}
