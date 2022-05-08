// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_popular.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviePopular _$MoviePopularFromJson(Map<String, dynamic> json) => MoviePopular(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$MoviePopularToJson(MoviePopular instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
