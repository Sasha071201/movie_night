// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeImages _$EpisodeImagesFromJson(Map<String, dynamic> json) =>
    EpisodeImages(
      id: json['id'] as int,
      stills: (json['stills'] as List<dynamic>)
          .map((e) => Still.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodeImagesToJson(EpisodeImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stills': instance.stills.map((e) => e.toJson()).toList(),
    };

Still _$StillFromJson(Map<String, dynamic> json) => Still(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      iso: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
    );

Map<String, dynamic> _$StillToJson(Still instance) => <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };
