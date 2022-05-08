import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movie_popular.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MoviePopular {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MoviePopular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$MoviePopularToJson(this);

  factory MoviePopular.fromJson(Map<String, dynamic> json) =>
      _$MoviePopularFromJson(json);
}
