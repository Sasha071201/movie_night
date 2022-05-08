// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_find.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaFind _$MediaFindFromJson(Map<String, dynamic> json) => MediaFind(
      movieResults: (json['movie_results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      personResults: (json['person_results'] as List<dynamic>)
          .map((e) => Actor.fromJson(e as Map<String, dynamic>))
          .toList(),
      tvResults: (json['tv_results'] as List<dynamic>)
          .map((e) => TvShow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaFindToJson(MediaFind instance) => <String, dynamic>{
      'movie_results': instance.movieResults.map((e) => e.toJson()).toList(),
      'person_results': instance.personResults.map((e) => e.toJson()).toList(),
      'tv_results': instance.tvResults.map((e) => e.toJson()).toList(),
    };
