// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonDetails _$SeasonDetailsFromJson(Map<String, dynamic> json) =>
    SeasonDetails(
      id1: json['_id'] as String?,
      airDate: parseDateFromString(json['air_date'] as String?),
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      id2: json['id'] as int,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int,
      aggregateCredits: AggregateCredits.fromJson(
          json['aggregate_credits'] as Map<String, dynamic>),
      videos: Videos.fromJson(json['videos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeasonDetailsToJson(SeasonDetails instance) =>
    <String, dynamic>{
      '_id': instance.id1,
      'air_date': instance.airDate?.toIso8601String(),
      'episodes': instance.episodes?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'overview': instance.overview,
      'id': instance.id2,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
      'aggregate_credits': instance.aggregateCredits.toJson(),
      'videos': instance.videos.toJson(),
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      airDate: parseDateFromString(json['air_date'] as String?),
      episodeNumber: json['episode_number'] as int,
      crew: (json['crew'] as List<dynamic>)
          .map((e) => EpisodeCrew.fromJson(e as Map<String, dynamic>))
          .toList(),
      guestStars: (json['guest_stars'] as List<dynamic>)
          .map((e) => GuestStar.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      productionCode: json['production_code'] as String,
      seasonNumber: json['season_number'] as int,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'air_date': instance.airDate?.toIso8601String(),
      'episode_number': instance.episodeNumber,
      'crew': instance.crew,
      'guest_stars': instance.guestStars,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'production_code': instance.productionCode,
      'season_number': instance.seasonNumber,
      'still_path': instance.stillPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

EpisodeCrew _$EpisodeCrewFromJson(Map<String, dynamic> json) => EpisodeCrew(
      job: json['job'] as String,
      department: json['department'] as String?,
      creditId: json['credit_id'] as String,
      adult: json['adult'] as bool?,
      gender: json['gender'] as int,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$EpisodeCrewToJson(EpisodeCrew instance) =>
    <String, dynamic>{
      'job': instance.job,
      'department': instance.department,
      'credit_id': instance.creditId,
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };

GuestStar _$GuestStarFromJson(Map<String, dynamic> json) => GuestStar(
      character: json['character'] as String,
      creditId: json['credit_id'] as String,
      order: json['order'] as int,
      adult: json['adult'] as bool?,
      gender: json['gender'] as int,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$GuestStarToJson(GuestStar instance) => <String, dynamic>{
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };

AggregateCredits _$AggregateCreditsFromJson(Map<String, dynamic> json) =>
    AggregateCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => Crew.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AggregateCreditsToJson(AggregateCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
    };

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      adult: json['adult'] as bool?,
      gender: json['gender'] as int,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalEpisodeCount: json['total_episode_count'] as int,
      order: json['order'] as int,
    );

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'roles': instance.roles,
      'total_episode_count': instance.totalEpisodeCount,
      'order': instance.order,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      creditId: json['credit_id'] as String,
      character: json['character'] as String,
      episodeCount: json['episode_count'] as int,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'credit_id': instance.creditId,
      'character': instance.character,
      'episode_count': instance.episodeCount,
    };

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
      adult: json['adult'] as bool?,
      gender: json['gender'] as int,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      jobs: (json['jobs'] as List<dynamic>)
          .map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
      department: json['department'] as String?,
      totalEpisodeCount: json['total_episode_count'] as int,
    );

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'jobs': instance.jobs,
      'department': instance.department,
      'total_episode_count': instance.totalEpisodeCount,
    };

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      creditId: json['credit_id'] as String,
      job: json['job'] as String,
      episodeCount: json['episode_count'] as int,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'credit_id': instance.creditId,
      'job': instance.job,
      'episode_count': instance.episodeCount,
    };

Videos _$VideosFromJson(Map<String, dynamic> json) => Videos(
      results: json['results'] as List<dynamic>,
    );

Map<String, dynamic> _$VideosToJson(Videos instance) => <String, dynamic>{
      'results': instance.results,
    };
