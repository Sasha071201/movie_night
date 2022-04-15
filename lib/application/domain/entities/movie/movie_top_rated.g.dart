// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_top_rated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieTopRated _$MovieTopRatedFromJson(Map<String, dynamic> json) =>
    MovieTopRated(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$MovieTopRatedToJson(MovieTopRated instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
