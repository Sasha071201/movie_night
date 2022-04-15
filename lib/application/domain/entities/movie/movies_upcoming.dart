import 'package:json_annotation/json_annotation.dart';
import 'package:movie_night/application/domain/entities/date_parser.dart';

import 'movie.dart';

part 'movies_upcoming.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MoviesUpcoming {
  final Dates dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MoviesUpcoming({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$MoviesUpcomingToJson(this);

  factory MoviesUpcoming.fromJson(Map<String, dynamic> json) => _$MoviesUpcomingFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Dates {
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? maximum;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? minimum;
  Dates({
    required this.maximum,
    required this.minimum,
  });

  Map<String, dynamic> toJson() => _$DatesToJson(this);

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

}