// To parse this JSON data, do
//
//     final musicGenreListModel = musicGenreListModelFromJson(jsonString);

import 'dart:convert';

MusicGenreListModel musicGenreListModelFromJson(String str) =>
    MusicGenreListModel.fromJson(json.decode(str));

String musicGenreListModelToJson(MusicGenreListModel data) =>
    json.encode(data.toJson());

class MusicGenreListModel {
  Toptags? toptags;

  MusicGenreListModel({
    this.toptags,
  });

  factory MusicGenreListModel.fromJson(Map<String, dynamic> json) =>
      MusicGenreListModel(
        toptags:
            json["toptags"] == null ? null : Toptags.fromJson(json["toptags"]),
      );

  Map<String, dynamic> toJson() => {
        "toptags": toptags?.toJson(),
      };
}

class Toptags {
  List<Tag>? tag;

  Toptags({
    this.tag,
  });

  factory Toptags.fromJson(Map<String, dynamic> json) => Toptags(
        tag: json["tag"] == null
            ? []
            : List<Tag>.from(json["tag"]!.map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tag":
            tag == null ? [] : List<dynamic>.from(tag!.map((x) => x.toJson())),
      };
}

class Tag {
  String? name;
  int? count;
  int? reach;

  Tag({
    this.name,
    this.count,
    this.reach,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"] ?? "",
        count: json["count"] ?? 0,
        reach: json["reach"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "reach": reach,
      };
}
