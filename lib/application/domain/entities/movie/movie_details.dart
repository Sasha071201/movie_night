import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_night/application/domain/entities/movie/movie_credits.dart';

import '../date_parser.dart';
import 'movie.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanie>? productionCompanies;
  final List<ProductionCountrie>? productionCountries;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final MovieCredits? credits;
  final MovieVideos? videos;
  final ExternalIds? externalIds;
  final Keywords? keywords;
  final MoviesRecommendations? recommendations;
  final MoviesSimilar? similar;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
    required this.videos,
    this.externalIds,
    this.keywords,
    required this.recommendations,
    this.similar,
  });

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  MovieDetails copyWith({
    bool? adult,
    String? backdropPath,
    BelongsToCollection? belongsToCollection,
    int? budget,
    List<Genre>? genres,
    String? homepage,
    int? id,
    String? imdbId,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    List<ProductionCompanie>? productionCompanies,
    List<ProductionCountrie>? productionCountries,
    DateTime? releaseDate,
    int? revenue,
    int? runtime,
    List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    MovieCredits? credits,
    MovieVideos? videos,
    ExternalIds? externalIds,
    Keywords? keywords,
    MoviesRecommendations? recommendations,
  }) {
    return MovieDetails(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      belongsToCollection: belongsToCollection ?? this.belongsToCollection,
      budget: budget ?? this.budget,
      genres: genres ?? this.genres,
      homepage: homepage ?? this.homepage,
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      releaseDate: releaseDate ?? this.releaseDate,
      revenue: revenue ?? this.revenue,
      runtime: runtime ?? this.runtime,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      credits: credits ?? this.credits,
      videos: videos ?? this.videos,
      externalIds: externalIds ?? this.externalIds,
      keywords: keywords ?? this.keywords,
      recommendations: recommendations ?? this.recommendations,
    );
  }
}

class MovieDetailsConverter extends drift.TypeConverter<MovieDetails, String> {
  const MovieDetailsConverter();
  @override
  MovieDetails? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return MovieDetails.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String? mapToSql(MovieDetails? value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BelongsToCollection {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;
  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  final int id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$GenreToJson(this);

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
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
class MovieVideos {
  final List<MovieVideo?> results;
  MovieVideos({
    required this.results,
  });

  Map<String, dynamic> toJson() => _$MovieVideosToJson(this);

  factory MovieVideos.fromJson(Map<String, dynamic> json) =>
      _$MovieVideosFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieVideo {
  @JsonKey(name: 'iso_639_1')
  final String iso_639_1;
  @JsonKey(name: 'iso_3166_1')
  final String iso_3166_1;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;
  MovieVideo({
    required this.iso_639_1,
    required this.iso_3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  Map<String, dynamic> toJson() => _$MovieVideoToJson(this);

  factory MovieVideo.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ExternalIds {
  final String? imdbId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;
  ExternalIds({
    required this.imdbId,
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
  final List<Keyword> keywords;
  Keywords({
    required this.keywords,
  });
  Map<String, dynamic> toJson() => _$KeywordsToJson(this);

  factory Keywords.fromJson(Map<String, dynamic> json) =>
      _$KeywordsFromJson(json);

  Keywords copyWith({
    List<Keyword>? keywords,
  }) {
    return Keywords(
      keywords: keywords ?? this.keywords,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Keyword {
  final int id;
  final String name;
  Keyword({
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toJson() => _$KeywordToJson(this);

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  Keyword copyWith({
    int? id,
    String? name,
  }) {
    return Keyword(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MoviesRecommendations {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MoviesRecommendations({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  Map<String, dynamic> toJson() => _$MoviesRecommendationsToJson(this);

  factory MoviesRecommendations.fromJson(Map<String, dynamic> json) =>
      _$MoviesRecommendationsFromJson(json);

  MoviesRecommendations copyWith({
    int? page,
    List<Movie>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return MoviesRecommendations(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MoviesSimilar {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
  MoviesSimilar({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => _$MoviesSimilarToJson(this);

  factory MoviesSimilar.fromJson(Map<String, dynamic> json) =>
      _$MoviesSimilarFromJson(json);
}
