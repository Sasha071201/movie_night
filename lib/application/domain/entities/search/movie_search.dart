import 'package:json_annotation/json_annotation.dart';

import '../movie/movie.dart';

part 'movie_search.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieSearch {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MovieSearch({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  Map<String, dynamic> toJson() => _$MovieSearchToJson(this);

  factory MovieSearch.fromJson(Map<String, dynamic> json) =>
      _$MovieSearchFromJson(json);
}
