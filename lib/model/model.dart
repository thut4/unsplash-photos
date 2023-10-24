import 'dart:convert';

List<PhotosModel> photosModelFromJson(String str) => List<PhotosModel>.from(
    json.decode(str).map((x) => PhotosModel.fromJson(x)));

String photosModelToJson(List<PhotosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotosModel {
  String id;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  String? description;
  String? altDescription;
  Urls urls;

  PhotosModel({
    required this.id,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.altDescription,
    required this.urls,
  });

  factory PhotosModel.fromJson(Map<String, dynamic> json) => PhotosModel(
        id: json["id"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["description"] ?? '',
        altDescription: json["alt_description"] ?? '',
        urls: Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description": description,
        "alt_description": altDescription,
        "urls": urls.toJson(),
      };
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;

  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}
