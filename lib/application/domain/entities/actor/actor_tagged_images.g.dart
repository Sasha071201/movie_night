// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_tagged_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorTaggedImages _$ActorTaggedImagesFromJson(Map<String, dynamic> json) =>
    ActorTaggedImages(
      id: json['id'] as int,
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) =>
              ActorTaggedImagesResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$ActorTaggedImagesToJson(ActorTaggedImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

ActorTaggedImagesResult _$ActorTaggedImagesResultFromJson(
        Map<String, dynamic> json) =>
    ActorTaggedImagesResult(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      filePath: json['file_path'] as String?,
      height: json['height'] as int,
      id: json['id'] as String?,
      iso: json['iso_639_1'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
      imageType: json['image_type'] as String?,
      media: Media.fromJson(json['media'] as Map<String, dynamic>),
      mediaType: json['media_type'] as String?,
    );

Map<String, dynamic> _$ActorTaggedImagesResultToJson(
        ActorTaggedImagesResult instance) =>
    <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'file_path': instance.filePath,
      'height': instance.height,
      'id': instance.id,
      'iso_639_1': instance.iso,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
      'image_type': instance.imageType,
      'media': instance.media,
      'media_type': instance.mediaType,
    };

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      title: json['title'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      voteCount: json['vote_count'] as int,
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      video: json['video'] as bool?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      posterPath: json['poster_path'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'title': instance.title,
      'vote_average': instance.voteAverage,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'vote_count': instance.voteCount,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'video': instance.video,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'poster_path': instance.posterPath,
      'popularity': instance.popularity,
    };
