import 'package:codetomobile/data/local_database/database_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'astronomical_object.g.dart';

@JsonSerializable()
class AstronomicalObject {
  @JsonKey(name: "apod_site")
  String? apodSite;
  String? copyright;
  String? date;
  String? description;
  String? hdurl;
  @JsonKey(name: "media_type")
  String? mediaType;
  String? title;
  String? url;
  @JsonKey(name: "thumbnail_url")
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

  static DataBaseObject getDatabaseObject() {
    return DataBaseObject(
        databaseColumns: databaseColumns, tableName: tableName);
  }

  static String tableName = "AstronomicalObject";
  static String apodSiteColumnName = "apod_site";

  static List<DatabaseColumn> databaseColumns = [
    DatabaseColumn(
        name: apodSiteColumnName,
        columnType: DbColumnType.TEXT,
        isPrimaryKey: true),
    DatabaseColumn(name: 'copyright', columnType: DbColumnType.TEXT),
    DatabaseColumn(name: 'date', columnType: DbColumnType.TEXT),
    DatabaseColumn(name: 'description', columnType: DbColumnType.TEXT),
    DatabaseColumn(name: 'hdurl', columnType: DbColumnType.TEXT),
    DatabaseColumn(name: 'media_type', columnType: DbColumnType.TEXT),
    DatabaseColumn(name: 'title', columnType: DbColumnType.TEXT),
    DatabaseColumn(name: 'url', columnType: DbColumnType.TEXT),
    DatabaseColumn(name: 'thumbnail_url', columnType: DbColumnType.TEXT),
  ];
}
