// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_actors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularActors _$PopularActorsFromJson(Map<String, dynamic> json) =>
    PopularActors(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Actor.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$PopularActorsToJson(PopularActors instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

KnownFor _$KnownForFromJson(Map<String, dynamic> json) => KnownFor(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      id: (json['id'] as num).toDouble(),
      mediaType: parseMediaTypeFromString(json['media_type'] as String),
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: parseDateFromString(json['release_date'] as String?),
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toDouble(),
    );

Map<String, dynamic> _$KnownForToJson(KnownFor instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'media_type': _$MediaTypeEnumMap[instance.mediaType],
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

const _$MediaTypeEnumMap = {
  MediaType.movie: 'movie',
  MediaType.tv: 'tv',
  MediaType.person: 'person',
};
