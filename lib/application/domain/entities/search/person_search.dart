import 'package:json_annotation/json_annotation.dart';
import 'package:movie_night/application/domain/entities/actor/actor.dart';

part 'person_search.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PersonSearch {
  final int page;
  final List<Actor> results;
  final int totalPages;
  final int totalResults;
  PersonSearch({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
    Map<String, dynamic> toJson() => _$PersonSearchToJson(this);

  factory PersonSearch.fromJson(Map<String, dynamic> json) =>
      _$PersonSearchFromJson(json);
}