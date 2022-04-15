import 'package:json_annotation/json_annotation.dart';

part 'episode_images.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class EpisodeImages {
  final int id;
  final List<Still> stills;
  EpisodeImages({
    required this.id,
    required this.stills,
  });

  
  Map<String, dynamic> toJson() => _$EpisodeImagesToJson(this);

  factory EpisodeImages.fromJson(Map<String, dynamic> json) =>
      _$EpisodeImagesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Still {
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;
  Still({
    required this.aspectRatio,
    required this.height,
    required this.iso,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  
  Map<String, dynamic> toJson() => _$StillToJson(this);

  factory Still.fromJson(Map<String, dynamic> json) =>
      _$StillFromJson(json);
}