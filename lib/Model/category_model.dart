// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String? message;
  List<CategoryModelDatum>? data;

  CategoryModel({
    this.message,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        message: json["Message"],
        data: json["data"] == null
            ? []
            : List<CategoryModelDatum>.from(
                json["data"]!.map((x) => CategoryModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryModelDatum {
  String? title;
  List<DatumDatum>? data;

  CategoryModelDatum({
    this.title,
    this.data,
  });

  factory CategoryModelDatum.fromJson(Map<String, dynamic> json) =>
      CategoryModelDatum(
        title: json["title"] ?? "",
        data: json["data"] == null
            ? []
            : List<DatumDatum>.from(
                json["data"]!.map((x) => DatumDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DatumDatum {
  String? subtitle;
  List<String>? subData;

  DatumDatum({
    this.subtitle,
    this.subData,
  });

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
        subtitle: json["subtitle"] ?? "",
        subData: json["subData"] == null
            ? []
            : List<String>.from(json["subData"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "subtitle": subtitle,
        "subData":
            subData == null ? [] : List<dynamic>.from(subData!.map((x) => x)),
      };
}
