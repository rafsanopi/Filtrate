// To parse this JSON data, do
//
//     final tvSeriesModel = tvSeriesModelFromJson(jsonString);

import 'dart:convert';

TvSeriesModel tvSeriesModelFromJson(String str) =>
    TvSeriesModel.fromJson(json.decode(str));

String tvSeriesModelToJson(TvSeriesModel data) => json.encode(data.toJson());

class TvSeriesModel {
  int? page;
  List<TvSeriesResult>? results;
  int? totalPages;
  int? totalResults;

  TvSeriesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<TvSeriesResult>.from(
                json["results"]!.map((x) => TvSeriesResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class TvSeriesResult {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  TvSeriesResult({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  factory TvSeriesResult.fromJson(Map<String, dynamic> json) => TvSeriesResult(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"] ?? 0,
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"] ?? "",
        originalName: json["original_name"] ?? "",
        overview: json["overview"] ?? "",
        popularity: json["popularity"] ?? 0.0,
        posterPath: json["poster_path"] ?? "",
        firstAirDate: json["first_air_date"] ?? "",
        name: json["name"] ?? "",
        voteAverage: json["vote_average"] ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
