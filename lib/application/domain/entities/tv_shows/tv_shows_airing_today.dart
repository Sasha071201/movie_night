import 'package:json_annotation/json_annotation.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';

part 'tv_shows_airing_today.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowsAiringToday {
  final int page;
  final List<TvShow> results;
  final int totalPages;
  final int totalResults;
  TvShowsAiringToday({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$TvShowsAiringTodayToJson(this);

  factory TvShowsAiringToday.fromJson(Map<String, dynamic> json) =>
      _$TvShowsAiringTodayFromJson(json);
}