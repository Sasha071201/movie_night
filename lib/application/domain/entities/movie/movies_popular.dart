import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movies_popular.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MoviesPopular {
  final int page;
  final List<Movie> results;
   final int totalPages;
  final int totalResults;
  MoviesPopular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });


  Map<String, dynamic> toJson() => _$MoviesPopularToJson(this);

  factory MoviesPopular.fromJson(Map<String, dynamic> json) => _$MoviesPopularFromJson(json);

}

