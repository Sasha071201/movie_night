// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorImages _$ActorImagesFromJson(Map<String, dynamic> json) => ActorImages(
      id: json['id'] as int,
      profiles: (json['profiles'] as List<dynamic>)
          .map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActorImagesToJson(ActorImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profiles': instance.profiles.map((e) => e.toJson()).toList(),
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      iso: json['iso_639_1'],
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };
