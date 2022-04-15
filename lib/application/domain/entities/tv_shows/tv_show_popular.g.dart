// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_popular.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowPopular _$TvShowPopularFromJson(Map<String, dynamic> json) =>
    TvShowPopular(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => TvShow.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$TvShowPopularToJson(TvShowPopular instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
