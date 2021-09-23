// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astronomical_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AstronomicalObject _$AstronomicalObjectFromJson(Map<String, dynamic> json) =>
    AstronomicalObject(
      apodSite: json['apodSite'] as String?,
      copyright: json['copyright'] as String?,
      date: json['date'] as String?,
      description: json['description'] as String?,
      hdurl: json['hdurl'] as String?,
      mediaType: json['mediaType'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$AstronomicalObjectToJson(AstronomicalObject instance) =>
    <String, dynamic>{
      'apodSite': instance.apodSite,
      'copyright': instance.copyright,
      'date': instance.date,
      'description': instance.description,
      'hdurl': instance.hdurl,
      'mediaType': instance.mediaType,
      'title': instance.title,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
