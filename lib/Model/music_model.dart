// To parse this JSON data, do
//
//     final musicModel = musicModelFromJson(jsonString);

import 'dart:convert';

MusicModel musicModelFromJson(String str) =>
    MusicModel.fromJson(json.decode(str));

String musicModelToJson(MusicModel data) => json.encode(data.toJson());

class MusicModel {
  Tracks? tracks;

  MusicModel({
    this.tracks,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
        tracks: json["tracks"] == null ? null : Tracks.fromJson(json["tracks"]),
      );

  Map<String, dynamic> toJson() => {
        "tracks": tracks?.toJson(),
      };
}

class Tracks {
  List<Track>? track;
  Attr? attr;

  Tracks({
    this.track,
    this.attr,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        track: json["track"] == null
            ? []
            : List<Track>.from(json["track"]!.map((x) => Track.fromJson(x))),
        attr: json["@attr"] == null ? null : Attr.fromJson(json["@attr"]),
      );

  Map<String, dynamic> toJson() => {
        "track": track == null
            ? []
            : List<dynamic>.from(track!.map((x) => x.toJson())),
        "@attr": attr?.toJson(),
      };
}

class Attr {
  String? page;
  String? perPage;
  String? totalPages;
  String? total;

  Attr({
    this.page,
    this.perPage,
    this.totalPages,
    this.total,
  });

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
        page: json["page"] ?? "",
        perPage: json["perPage"] ?? "",
        totalPages: json["totalPages"] ?? "",
        total: json["total"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "total": total,
      };
}

class Track {
  String? name;

  String? listeners;

  List<Image>? image;

  Track({
    this.name,
    this.listeners,
    this.image,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        name: json["name"] ?? "",
        listeners: json["listeners"] ?? "",
        image: json["image"] == null
            ? []
            : List<Image>.from(json["image"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "listeners": listeners,
        "image": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
      };
}

class Image {
  String? text;
  Size? size;

  Image({
    this.text,
    this.size,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        text: json["#text"],
        size: sizeValues.map[json["size"]]!,
      );

  Map<String, dynamic> toJson() => {
        "#text": text,
        "size": sizeValues.reverse[size],
      };
}

// ignore: constant_identifier_names
enum Size { EXTRALARGE, LARGE, MEDIUM, SMALL }

final sizeValues = EnumValues({
  "extralarge": Size.EXTRALARGE,
  "large": Size.LARGE,
  "medium": Size.MEDIUM,
  "small": Size.SMALL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
