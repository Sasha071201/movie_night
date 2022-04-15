import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movie_now_playing.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieNowPlaying {
  final Dates dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MovieNowPlaying({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$MovieNowPlayingToJson(this);

  factory MovieNowPlaying.fromJson(Map<String, dynamic> json) =>
      _$MovieNowPlayingFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Dates {
  final String maximum;
  final String minimum;
  Dates({
    required this.maximum,
    required this.minimum,
  });

  Map<String, dynamic> toJson() => _$DatesToJson(this);

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
}
