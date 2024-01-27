// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublishRequestImpl _$$PublishRequestImplFromJson(Map<String, dynamic> json) =>
    _$PublishRequestImpl(
      synd_id: json['synd_id'] as int,
      name_en: json['name_en'] as String,
      name_ar: json['name_ar'] as String,
      published: json['published'] as bool,
    );

Map<String, dynamic> _$$PublishRequestImplToJson(
        _$PublishRequestImpl instance) =>
    <String, dynamic>{
      'synd_id': instance.synd_id,
      'name_en': instance.name_en,
      'name_ar': instance.name_ar,
      'published': instance.published,
    };
