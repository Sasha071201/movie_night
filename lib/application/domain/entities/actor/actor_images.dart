import 'package:json_annotation/json_annotation.dart';

part 'actor_images.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ActorImages {
  final int id;
  final List<Profile> profiles;
  ActorImages({
    required this.id,
    required this.profiles,
  });
  
  Map<String, dynamic> toJson() => _$ActorImagesToJson(this);

  factory ActorImages.fromJson(Map<String, dynamic> json) =>
      _$ActorImagesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Profile {
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final dynamic iso;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;
  Profile({
    required this.aspectRatio,
    required this.height,
    required this.iso,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}