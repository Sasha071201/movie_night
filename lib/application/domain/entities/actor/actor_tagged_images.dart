import 'package:json_annotation/json_annotation.dart';

part 'actor_tagged_images.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ActorTaggedImages {
  final int id;
  final int page;
  final List<ActorTaggedImagesResult> results;
  final int totalPages;
  final int totalResults;
  ActorTaggedImages({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  
  Map<String, dynamic> toJson() => _$ActorTaggedImagesToJson(this);

  factory ActorTaggedImages.fromJson(Map<String, dynamic> json) =>
      _$ActorTaggedImagesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ActorTaggedImagesResult {
  final double? aspectRatio;
  final String? filePath;
  final int height;
  final String? id;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  final double? voteAverage;
  final int voteCount;
  final int width;
  final String? imageType;
  final Media media;
  final String? mediaType;
  ActorTaggedImagesResult({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.id,
    required this.iso,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
    required this.imageType,
    required this.media,
    required this.mediaType,
  }); 
  
  Map<String, dynamic> toJson() => _$ActorTaggedImagesResultToJson(this);

  factory ActorTaggedImagesResult.fromJson(Map<String, dynamic> json) =>
      _$ActorTaggedImagesResultFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Media {
  final String? title;
  final double? voteAverage;
  final String? overview;
  final String? releaseDate;
  final int voteCount;
  final bool? adult;
  final String? backdropPath;
  final bool? video;
  final List<int>? genreIds;
  final int id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? posterPath;
  final double? popularity;
  Media({
    required this.title,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
    required this.voteCount,
    required this.adult,
    required this.backdropPath,
    required this.video,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.posterPath,
    required this.popularity,
  });

  Map<String, dynamic> toJson() => _$MediaToJson(this);

  factory Media.fromJson(Map<String, dynamic> json) =>
      _$MediaFromJson(json);
}