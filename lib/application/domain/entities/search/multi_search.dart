import 'package:json_annotation/json_annotation.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';

import '../date_parser.dart';

part 'multi_search.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MultiSearch {
  final int page;
  final List<MultiSearchResult> results;
  final int totalPages;
  final int totalResults;
  MultiSearch({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$MultiSearchToJson(this);

  factory MultiSearch.fromJson(Map<String, dynamic> json) =>
      _$MultiSearchFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MultiSearchResult {
  final int id;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;
  final List<int>? genreIds;
  @JsonKey(fromJson: parseMediaTypeFromString)
  final MediaType? mediaType;
  final String? posterPath;
  final String? profilePath;
  final double? voteAverage;
  final int? gender;
  final String? title;
  final String? name;

  MultiSearchResult({
    required this.id,
    this.releaseDate,
    this.firstAirDate,
    this.genreIds,
    required this.mediaType,
    this.posterPath,
    this.profilePath,
    this.voteAverage,
    this.gender,
    this.title,
    this.name,
  });

  Map<String, dynamic> toJson() => _$MultiSearchResultToJson(this);

  factory MultiSearchResult.fromJson(Map<String, dynamic> json) =>
      _$MultiSearchResultFromJson(json);

  static MediaType? parseMediaTypeFromString(String rawMediaType) {
    switch(rawMediaType){
      case 'movie': return MediaType.movie; 
      case 'tv': return MediaType.tv;
      case 'person': return MediaType.person;
    }
    return null;
  }
}
