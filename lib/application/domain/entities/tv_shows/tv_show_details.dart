import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';

import '../date_parser.dart';

part 'tv_show_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowDetails {
  final bool adult;
  final String? backdropPath;
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;
  final List<TvShowGenre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String name;
  final NextEpisodeToAir? nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity; 
  final String? posterPath;
  final List<ProductionCompanie> productionCompanies;
  final List<ProductionCountrie> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;
  final AggregateCredits aggregateCredits;
  final ExternalIds externalIds;
  final Keywords keywords;
  final TvShowRecommendations recommendations;
  final TvShowSimilar similar;
  final Videos videos;
  TvShowDetails({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    required this.aggregateCredits,
    required this.externalIds,
    required this.keywords,
    required this.recommendations,
    required this.similar,
    required this.videos,
  });

  Map<String, dynamic> toJson() => _$TvShowDetailsToJson(this);

  factory TvShowDetails.fromJson(Map<String, dynamic> json) =>
      _$TvShowDetailsFromJson(json);

  TvShowDetails copyWith({
    bool? adult,
    String? backdropPath,
    List<CreatedBy>? createdBy,
    List<int>? episodeRunTime,
    DateTime? firstAirDate,
    List<TvShowGenre>? genres,
    String? homepage,
    int? id,
    bool? inProduction,
    List<String>? languages,
    DateTime? lastAirDate,
    LastEpisodeToAir? lastEpisodeToAir,
    String? name,
    NextEpisodeToAir? nextEpisodeToAir,
    List<Network>? networks,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    List<ProductionCompanie>? productionCompanies,
    List<ProductionCountrie>? productionCountries,
    List<Season>? seasons,
    List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    int? voteCount,
    AggregateCredits? aggregateCredits,
    ExternalIds? externalIds,
    Keywords? keywords,
    TvShowRecommendations? recommendations,
    TvShowSimilar? similar,
    Videos? videos,
  }) {
    return TvShowDetails(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      createdBy: createdBy ?? this.createdBy,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      genres: genres ?? this.genres,
      homepage: homepage ?? this.homepage,
      id: id ?? this.id,
      inProduction: inProduction ?? this.inProduction,
      languages: languages ?? this.languages,
      lastAirDate: lastAirDate ?? this.lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir ?? this.lastEpisodeToAir,
      name: name ?? this.name,
      nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
      networks: networks ?? this.networks,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      seasons: seasons ?? this.seasons,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      type: type ?? this.type,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      aggregateCredits: aggregateCredits ?? this.aggregateCredits,
      externalIds: externalIds ?? this.externalIds,
      keywords: keywords ?? this.keywords,
      recommendations: recommendations ?? this.recommendations,
      similar: similar ?? this.similar,
      videos: videos ?? this.videos,
    );
  }
}

class TvShowDetailsConverter extends drift.TypeConverter<TvShowDetails, String> {
  const TvShowDetailsConverter();
  @override
  TvShowDetails? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return TvShowDetails.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String? mapToSql(TvShowDetails? value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatedBy {
  final int id;
  final String creditId;
  final String name;
  final int? gender;
  final String? profilePath;
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TvShowGenre {
  final int id;
  final String name;
  TvShowGenre({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$TvShowGenreToJson(this);

  factory TvShowGenre.fromJson(Map<String, dynamic> json) =>
      _$TvShowGenreFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LastEpisodeToAir {
  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      _$LastEpisodeToAirFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NextEpisodeToAir {
  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  NextEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });
  Map<String, dynamic> toJson() => _$NextEpisodeToAirToJson(this);

  factory NextEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      _$NextEpisodeToAirFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Network {
  final String name;
  final int id;
  final String? logoPath;
  final String originCountry;
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });
  Map<String, dynamic> toJson() => _$NetworkToJson(this);

  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanie {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  ProductionCompanie({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  Map<String, dynamic> toJson() => _$ProductionCompanieToJson(this);

  factory ProductionCompanie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanieFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountrie {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;
  ProductionCountrie({
    required this.iso,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$ProductionCountrieToJson(this);

  factory ProductionCountrie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountrieFromJson(json);

  ProductionCountrie copyWith({
    String? iso,
    String? name,
  }) {
    return ProductionCountrie(
      iso: iso ?? this.iso,
      name: name ?? this.name,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Season {
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;
  SpokenLanguage({
    required this.englishName,
    required this.iso,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AggregateCredits {
  final List<TvShowCast> cast;
  final List<TvShowCrew> crew;
  AggregateCredits({
    required this.cast,
    required this.crew,
  });

  Map<String, dynamic> toJson() => _$AggregateCreditsToJson(this);

  factory AggregateCredits.fromJson(Map<String, dynamic> json) =>
      _$AggregateCreditsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TvShowCast {
  final bool adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<Role> roles;
  final int totalEpisodeCount;
  final int order;
  TvShowCast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.roles,
    required this.totalEpisodeCount,
    required this.order,
  });

  Map<String, dynamic> toJson() => _$TvShowCastToJson(this);

  factory TvShowCast.fromJson(Map<String, dynamic> json) => _$TvShowCastFromJson(json);

  TvShowCast copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    List<Role>? roles,
    int? totalEpisodeCount,
    int? order,
  }) {
    return TvShowCast(
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
      roles: roles ?? this.roles,
      totalEpisodeCount: totalEpisodeCount ?? this.totalEpisodeCount,
      order: order ?? this.order,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Role {
  final String creditId;
  final String character;
  final int episodeCount;
  Role({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Role copyWith({
    String? creditId,
    String? character,
    int? episodeCount,
  }) {
    return Role(
      creditId: creditId ?? this.creditId,
      character: character ?? this.character,
      episodeCount: episodeCount ?? this.episodeCount,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TvShowCrew {
  final bool adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<Job> jobs;
  final String department;
  final int totalEpisodeCount;
  TvShowCrew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.jobs,
    required this.department,
    required this.totalEpisodeCount,
  });

  Map<String, dynamic> toJson() => _$TvShowCrewToJson(this);

  factory TvShowCrew.fromJson(Map<String, dynamic> json) => _$TvShowCrewFromJson(json);

  TvShowCrew copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    List<Job>? jobs,
    String? department,
    int? totalEpisodeCount,
  }) {
    return TvShowCrew(
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
      jobs: jobs ?? this.jobs,
      department: department ?? this.department,
      totalEpisodeCount: totalEpisodeCount ?? this.totalEpisodeCount,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Job {
  final String creditId;
  final String job;
  final int episodeCount;
  Job({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  Map<String, dynamic> toJson() => _$JobToJson(this);

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ExternalIds {
  final String? imdbId;
  final String? freebaseMid;
  final String? freebaseId;
  final int? tvdbId;
  final int? tvrageId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;
  ExternalIds({
    required this.imdbId,
    required this.freebaseMid,
    required this.freebaseId,
    required this.tvdbId,
    required this.tvrageId,
    required this.facebookId,
    required this.instagramId,
    required this.twitterId,
  });

  Map<String, dynamic> toJson() => _$ExternalIdsToJson(this);

  factory ExternalIds.fromJson(Map<String, dynamic> json) =>
      _$ExternalIdsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Keywords {
  final List<Keyword>? keywords;
  Keywords({
    required this.keywords,
  });

  Map<String, dynamic> toJson() => _$KeywordsToJson(this);

  factory Keywords.fromJson(Map<String, dynamic> json) =>
      _$KeywordsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Keyword {
  final String name;
  final int id;
  Keyword({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toJson() => _$KeywordToJson(this);

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  Keyword copyWith({
    String? name,
    int? id,
  }) {
    return Keyword(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TvShowRecommendations {
  final int page;
  final List<TvShow> results;
  final int totalPages;
  final int totalResults;
  TvShowRecommendations({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$TvShowRecommendationsToJson(this);

  factory TvShowRecommendations.fromJson(Map<String, dynamic> json) =>
      _$TvShowRecommendationsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TvShowSimilar {
  final int page;
  final List<TvShow> results;
  final int totalPages;
  final int totalResults;
  TvShowSimilar({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  
  Map<String, dynamic> toJson() => _$TvShowSimilarToJson(this);

  factory TvShowSimilar.fromJson(Map<String, dynamic> json) =>
      _$TvShowSimilarFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Videos {
  final List<VideoResult> results;
  Videos({
    required this.results,
  });

  
  Map<String, dynamic> toJson() => _$VideosToJson(this);

  factory Videos.fromJson(Map<String, dynamic> json) =>
      _$VideosFromJson(json);

}

@JsonSerializable(fieldRename: FieldRename.snake)
class VideoResult {
  @JsonKey(name: 'iso_639_1')
  final String iso1;
  @JsonKey(name: 'iso_3166_1')
  final String iso2;
  final String name;
  final String key;
  final String publishedAt;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String id;
  VideoResult({
    required this.iso1,
    required this.iso2,
    required this.name,
    required this.key,
    required this.publishedAt,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.id,
  });
   
  Map<String, dynamic> toJson() => _$VideoResultToJson(this);

  factory VideoResult.fromJson(Map<String, dynamic> json) =>
      _$VideoResultFromJson(json);
}
