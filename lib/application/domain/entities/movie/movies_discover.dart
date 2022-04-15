import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movies_discover.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MoviesDiscover {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MoviesDiscover({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$MoviesDiscoverToJson(this);

  factory MoviesDiscover.fromJson(Map<String, dynamic> json) => _$MoviesDiscoverFromJson(json);

}