// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowDetails _$TvShowDetailsFromJson(Map<String, dynamic> json) =>
    TvShowDetails(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      createdBy: (json['created_by'] as List<dynamic>)
          .map((e) => CreatedBy.fromJson(e as Map<String, dynamic>))
          .toList(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      firstAirDate: parseDateFromString(json['first_air_date'] as String?),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => TvShowGenre.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String,
      id: json['id'] as int,
      inProduction: json['in_production'] as bool,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      lastAirDate: parseDateFromString(json['last_air_date'] as String?),
      lastEpisodeToAir: json['last_episode_to_air'] == null
          ? null
          : LastEpisodeToAir.fromJson(
              json['last_episode_to_air'] as Map<String, dynamic>),
      name: json['name'] as String,
      nextEpisodeToAir: json['next_episode_to_air'] == null
          ? null
          : NextEpisodeToAir.fromJson(
              json['next_episode_to_air'] as Map<String, dynamic>),
      networks: (json['networks'] as List<dynamic>)
          .map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfEpisodes: json['number_of_episodes'] as int,
      numberOfSeasons: json['number_of_seasons'] as int,
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>)
          .map((e) => ProductionCompanie.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>)
          .map((e) => ProductionCountrie.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>)
          .map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>)
          .map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      tagline: json['tagline'] as String,
      type: json['type'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      aggregateCredits: AggregateCredits.fromJson(
          json['aggregate_credits'] as Map<String, dynamic>),
      externalIds:
          ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>),
      keywords: Keywords.fromJson(json['keywords'] as Map<String, dynamic>),
      recommendations: TvShowRecommendations.fromJson(
          json['recommendations'] as Map<String, dynamic>),
      similar: TvShowSimilar.fromJson(json['similar'] as Map<String, dynamic>),
      videos: Videos.fromJson(json['videos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TvShowDetailsToJson(TvShowDetails instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'created_by': instance.createdBy.map((e) => e.toJson()).toList(),
      'episode_run_time': instance.episodeRunTime,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'genres': instance.genres.map((e) => e.toJson()).toList(),
      'homepage': instance.homepage,
      'id': instance.id,
      'in_production': instance.inProduction,
      'languages': instance.languages,
      'last_air_date': instance.lastAirDate?.toIso8601String(),
      'last_episode_to_air': instance.lastEpisodeToAir?.toJson(),
      'name': instance.name,
      'next_episode_to_air': instance.nextEpisodeToAir?.toJson(),
      'networks': instance.networks.map((e) => e.toJson()).toList(),
      'number_of_episodes': instance.numberOfEpisodes,
      'number_of_seasons': instance.numberOfSeasons,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'production_companies':
          instance.productionCompanies.map((e) => e.toJson()).toList(),
      'production_countries':
          instance.productionCountries.map((e) => e.toJson()).toList(),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'spoken_languages':
          instance.spokenLanguages.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'tagline': instance.tagline,
      'type': instance.type,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'aggregate_credits': instance.aggregateCredits.toJson(),
      'external_ids': instance.externalIds.toJson(),
      'keywords': instance.keywords.toJson(),
      'recommendations': instance.recommendations.toJson(),
      'similar': instance.similar.toJson(),
      'videos': instance.videos.toJson(),
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      id: json['id'] as int,
      creditId: json['credit_id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as int?,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'id': instance.id,
      'credit_id': instance.creditId,
      'name': instance.name,
      'gender': instance.gender,
      'profile_path': instance.profilePath,
    };

TvShowGenre _$TvShowGenreFromJson(Map<String, dynamic> json) => TvShowGenre(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TvShowGenreToJson(TvShowGenre instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

LastEpisodeToAir _$LastEpisodeToAirFromJson(Map<String, dynamic> json) =>
    LastEpisodeToAir(
      airDate: json['air_date'] as String,
      episodeNumber: json['episode_number'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      productionCode: json['production_code'] as String,
      seasonNumber: json['season_number'] as int,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$LastEpisodeToAirToJson(LastEpisodeToAir instance) =>
    <String, dynamic>{
      'air_date': instance.airDate,
      'episode_number': instance.episodeNumber,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'production_code': instance.productionCode,
      'season_number': instance.seasonNumber,
      'still_path': instance.stillPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

NextEpisodeToAir _$NextEpisodeToAirFromJson(Map<String, dynamic> json) =>
    NextEpisodeToAir(
      airDate: json['air_date'] as String,
      episodeNumber: json['episode_number'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      productionCode: json['production_code'] as String,
      seasonNumber: json['season_number'] as int,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$NextEpisodeToAirToJson(NextEpisodeToAir instance) =>
    <String, dynamic>{
      'air_date': instance.airDate,
      'episode_number': instance.episodeNumber,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'production_code': instance.productionCode,
      'season_number': instance.seasonNumber,
      'still_path': instance.stillPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      name: json['name'] as String,
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String,
    );

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'logo_path': instance.logoPath,
      'origin_country': instance.originCountry,
    };

ProductionCompanie _$ProductionCompanieFromJson(Map<String, dynamic> json) =>
    ProductionCompanie(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String,
    );

Map<String, dynamic> _$ProductionCompanieToJson(ProductionCompanie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };

ProductionCountrie _$ProductionCountrieFromJson(Map<String, dynamic> json) =>
    ProductionCountrie(
      iso: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductionCountrieToJson(ProductionCountrie instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso,
      'name': instance.name,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      airDate: parseDateFromString(json['air_date'] as String?),
      episodeCount: json['episode_count'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'air_date': instance.airDate?.toIso8601String(),
      'episode_count': instance.episodeCount,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
    };

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      englishName: json['english_name'] as String,
      iso: json['iso_639_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SpokenLanguageToJson(SpokenLanguage instance) =>
    <String, dynamic>{
      'english_name': instance.englishName,
      'iso_639_1': instance.iso,
      'name': instance.name,
    };

AggregateCredits _$AggregateCreditsFromJson(Map<String, dynamic> json) =>
    AggregateCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => TvShowCast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => TvShowCrew.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AggregateCreditsToJson(AggregateCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
    };

TvShowCast _$TvShowCastFromJson(Map<String, dynamic> json) => TvShowCast(
      adult: json['adult'] as bool,
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

Map<String, dynamic> _$TvShowCastToJson(TvShowCast instance) =>
    <String, dynamic>{
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

TvShowCrew _$TvShowCrewFromJson(Map<String, dynamic> json) => TvShowCrew(
      adult: json['adult'] as bool,
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
      department: json['department'] as String,
      totalEpisodeCount: json['total_episode_count'] as int,
    );

Map<String, dynamic> _$TvShowCrewToJson(TvShowCrew instance) =>
    <String, dynamic>{
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

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) => ExternalIds(
      imdbId: json['imdb_id'] as String?,
      freebaseMid: json['freebase_mid'] as String?,
      freebaseId: json['freebase_id'] as String?,
      tvdbId: json['tvdb_id'] as int?,
      tvrageId: json['tvrage_id'] as int?,
      facebookId: json['facebook_id'] as String?,
      instagramId: json['instagram_id'] as String?,
      twitterId: json['twitter_id'] as String?,
    );

Map<String, dynamic> _$ExternalIdsToJson(ExternalIds instance) =>
    <String, dynamic>{
      'imdb_id': instance.imdbId,
      'freebase_mid': instance.freebaseMid,
      'freebase_id': instance.freebaseId,
      'tvdb_id': instance.tvdbId,
      'tvrage_id': instance.tvrageId,
      'facebook_id': instance.facebookId,
      'instagram_id': instance.instagramId,
      'twitter_id': instance.twitterId,
    };

Keywords _$KeywordsFromJson(Map<String, dynamic> json) => Keywords(
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => Keyword.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KeywordsToJson(Keywords instance) => <String, dynamic>{
      'keywords': instance.keywords,
    };

Keyword _$KeywordFromJson(Map<String, dynamic> json) => Keyword(
      name: json['name'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

TvShowRecommendations _$TvShowRecommendationsFromJson(
        Map<String, dynamic> json) =>
    TvShowRecommendations(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => TvShow.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$TvShowRecommendationsToJson(
        TvShowRecommendations instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

TvShowSimilar _$TvShowSimilarFromJson(Map<String, dynamic> json) =>
    TvShowSimilar(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => TvShow.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$TvShowSimilarToJson(TvShowSimilar instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Videos _$VideosFromJson(Map<String, dynamic> json) => Videos(
      results: (json['results'] as List<dynamic>)
          .map((e) => VideoResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideosToJson(Videos instance) => <String, dynamic>{
      'results': instance.results,
    };

VideoResult _$VideoResultFromJson(Map<String, dynamic> json) => VideoResult(
      iso1: json['iso_639_1'] as String,
      iso2: json['iso_3166_1'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      publishedAt: json['published_at'] as String,
      site: json['site'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      official: json['official'] as bool,
      id: json['id'] as String,
    );

Map<String, dynamic> _$VideoResultToJson(VideoResult instance) =>
    <String, dynamic>{
      'iso_639_1': instance.iso1,
      'iso_3166_1': instance.iso2,
      'name': instance.name,
      'key': instance.key,
      'published_at': instance.publishedAt,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'id': instance.id,
    };
