import 'package:json_annotation/json_annotation.dart';

import '../actor/actor.dart';
import '../movie/movie.dart';
import '../tv_shows/tv_show.dart';

part 'media_find.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MediaFind {
  final List<Movie> movieResults;
  final List<Actor> personResults;
  final List<TvShow> tvResults;
  MediaFind({
    required this.movieResults,
    required this.personResults,
    required this.tvResults,
  });

  Map<String, dynamic> toJson() => _$MediaFindToJson(this);

  factory MediaFind.fromJson(Map<String, dynamic> json) =>
      _$MediaFindFromJson(json);
}
