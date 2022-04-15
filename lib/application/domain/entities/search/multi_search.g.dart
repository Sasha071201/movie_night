// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSearch _$MultiSearchFromJson(Map<String, dynamic> json) => MultiSearch(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MultiSearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$MultiSearchToJson(MultiSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

MultiSearchResult _$MultiSearchResultFromJson(Map<String, dynamic> json) =>
    MultiSearchResult(
      id: json['id'] as int,
      releaseDate: parseDateFromString(json['release_date'] as String?),
      firstAirDate: parseDateFromString(json['first_air_date'] as String?),
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      mediaType: MultiSearchResult.parseMediaTypeFromString(
          json['media_type'] as String),
      posterPath: json['poster_path'] as String?,
      profilePath: json['profile_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      gender: json['gender'] as int?,
      title: json['title'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MultiSearchResultToJson(MultiSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'release_date': instance.releaseDate?.toIso8601String(),
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'genre_ids': instance.genreIds,
      'media_type': _$MediaTypeEnumMap[instance.mediaType],
      'poster_path': instance.posterPath,
      'profile_path': instance.profilePath,
      'vote_average': instance.voteAverage,
      'gender': instance.gender,
      'title': instance.title,
      'name': instance.name,
    };

const _$MediaTypeEnumMap = {
  MediaType.movie: 'movie',
  MediaType.tv: 'tv',
  MediaType.person: 'person',
};
