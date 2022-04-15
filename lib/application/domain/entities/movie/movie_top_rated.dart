import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movie_top_rated.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieTopRated {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MovieTopRated({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$MovieTopRatedToJson(this);

  factory MovieTopRated.fromJson(Map<String, dynamic> json) =>
      _$MovieTopRatedFromJson(json);
}
