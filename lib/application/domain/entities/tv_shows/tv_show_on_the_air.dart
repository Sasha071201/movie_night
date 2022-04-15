import 'package:json_annotation/json_annotation.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';

part 'tv_show_on_the_air.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowOnTheAir {
  final int page;
  final List<TvShow> results;
  final int totalPages;
  final int totalResults;
  TvShowOnTheAir({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  
  Map<String, dynamic> toJson() => _$TvShowOnTheAirToJson(this);

  factory TvShowOnTheAir.fromJson(Map<String, dynamic> json) =>
      _$TvShowOnTheAirFromJson(json);
}