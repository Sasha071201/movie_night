// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_now_playing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieNowPlaying _$MovieNowPlayingFromJson(Map<String, dynamic> json) =>
    MovieNowPlaying(
      dates: Dates.fromJson(json['dates'] as Map<String, dynamic>),
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$MovieNowPlayingToJson(MovieNowPlaying instance) =>
    <String, dynamic>{
      'dates': instance.dates.toJson(),
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Dates _$DatesFromJson(Map<String, dynamic> json) => Dates(
      maximum: json['maximum'] as String,
      minimum: json['minimum'] as String,
    );

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
      'maximum': instance.maximum,
      'minimum': instance.minimum,
    };
