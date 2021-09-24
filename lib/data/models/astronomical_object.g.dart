// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astronomical_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AstronomicalObject _$AstronomicalObjectFromJson(Map<String, dynamic> json) {
  return AstronomicalObject(
    apodSite: json['apod_site'] as String?,
    copyright: json['copyright'] as String?,
    date: json['date'] as String?,
    description: json['description'] as String?,
    hdurl: json['hdurl'] as String?,
    mediaType: json['media_type'] as String?,
    title: json['title'] as String?,
    url: json['url'] as String?,
    thumbnailUrl: json['thumbnail_url'] as String?,
  );
}

Map<String, dynamic> _$AstronomicalObjectToJson(AstronomicalObject instance) =>
    <String, dynamic>{
      'apod_site': instance.apodSite,
      'copyright': instance.copyright,
      'date': instance.date,
      'description': instance.description,
      'hdurl': instance.hdurl,
      'media_type': instance.mediaType,
      'title': instance.title,
      'url': instance.url,
      'thumbnail_url': instance.thumbnailUrl,
    };
