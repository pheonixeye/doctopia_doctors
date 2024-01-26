// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$AppNotificationImpl(
      id: json['id'] as String,
      title_en: json['title_en'] as String,
      title_ar: json['title_ar'] as String,
      body_en: json['body_en'] as String,
      body_ar: json['body_ar'] as String,
    );

Map<String, dynamic> _$$AppNotificationImplToJson(
        _$AppNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_en': instance.title_en,
      'title_ar': instance.title_ar,
      'body_en': instance.body_en,
      'body_ar': instance.body_ar,
    };
