// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonSearch _$PersonSearchFromJson(Map<String, dynamic> json) => PersonSearch(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Actor.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$PersonSearchToJson(PersonSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
