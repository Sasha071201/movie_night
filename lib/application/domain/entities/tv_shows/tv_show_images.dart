import 'package:json_annotation/json_annotation.dart';

part 'tv_show_images.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowImages {
  final List<Backdrop> backdrops;
  final int id;
  final List<Logo> logos;
  final List<Poster> posters;
  TvShowImages({
    required this.backdrops,
    required this.id,
    required this.logos,
    required this.posters,
  });

  
  Map<String, dynamic> toJson() => _$TvShowImagesToJson(this);

  factory TvShowImages.fromJson(Map<String, dynamic> json) =>
      _$TvShowImagesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Backdrop {
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  final String? filePath;
  final double voteAverage;
  final int voteCount;
  final int width;
  Backdrop({
    required this.aspectRatio,
    required this.height,
    required this.iso,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  
  Map<String, dynamic> toJson() => _$BackdropToJson(this);

  factory Backdrop.fromJson(Map<String, dynamic> json) =>
      _$BackdropFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Logo {
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  final String? filePath;
  final double voteAverage;
  final int voteCount;
  final int width;
  Logo({
    required this.aspectRatio,
    required this.height,
    required this.iso,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  
  Map<String, dynamic> toJson() => _$LogoToJson(this);

  factory Logo.fromJson(Map<String, dynamic> json) =>
      _$LogoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Poster {
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  final String? filePath;
  final double voteAverage;
  final int voteCount;
  final int width;
  Poster({
    required this.aspectRatio,
    required this.height,
    required this.iso,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  
  Map<String, dynamic> toJson() => _$PosterToJson(this);

  factory Poster.fromJson(Map<String, dynamic> json) =>
      _$PosterFromJson(json);
}
