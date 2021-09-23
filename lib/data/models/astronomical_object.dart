import 'package:json_annotation/json_annotation.dart';

part 'astronomical_object.g.dart';

@JsonSerializable()
class AstronomicalObject {
  String? apodSite;
  String? copyright;
  String? date;
  String? description;
  String? hdurl;
  String? mediaType;
  String? title;
  String? url;
  String? thumbnailUrl;

  AstronomicalObject(
      {this.apodSite,
      this.copyright,
      this.date,
      this.description,
      this.hdurl,
      this.mediaType,
      this.title,
      this.url,
      this.thumbnailUrl});

  factory AstronomicalObject.fromJson(Map<String, dynamic> json) =>
      _$AstronomicalObjectFromJson(json);

  Map<String, dynamic> toJson() => _$AstronomicalObjectToJson(this);
}
