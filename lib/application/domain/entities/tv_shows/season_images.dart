import 'package:json_annotation/json_annotation.dart';

part 'season_images.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SeasonImages {
  final int id;
  final List<Poster> posters;
  SeasonImages({
    required this.id,
    required this.posters,
  });

  Map<String, dynamic> toJson() => _$SeasonImagesToJson(this);

  factory SeasonImages.fromJson(Map<String, dynamic> json) =>
      _$SeasonImagesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Poster {
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  final String? filePath;
  final double? voteAverage;
  final int voteCount;
  final int width;
  Poster({
    required this.aspectRatio,
    required this.height,
    this.iso,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  Map<String, dynamic> toJson() => _$PosterToJson(this);

  factory Poster.fromJson(Map<String, dynamic> json) => _$PosterFromJson(json);
}
