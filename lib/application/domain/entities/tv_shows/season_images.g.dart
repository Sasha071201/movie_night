// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonImages _$SeasonImagesFromJson(Map<String, dynamic> json) => SeasonImages(
      id: json['id'] as int,
      posters: (json['posters'] as List<dynamic>)
          .map((e) => Poster.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeasonImagesToJson(SeasonImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'posters': instance.posters.map((e) => e.toJson()).toList(),
    };

Poster _$PosterFromJson(Map<String, dynamic> json) => Poster(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      iso: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
    );

Map<String, dynamic> _$PosterToJson(Poster instance) => <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };
