import 'package:json_annotation/json_annotation.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';

part 'tv_show_search.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowSearch {
  final int page;
  final List<TvShow> results;
  final int totalPages;
  final int totalResults;
  TvShowSearch({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  
    Map<String, dynamic> toJson() => _$TvShowSearchToJson(this);

  factory TvShowSearch.fromJson(Map<String, dynamic> json) =>
      _$TvShowSearchFromJson(json);
}