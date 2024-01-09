// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicImagesImpl _$$ClinicImagesImplFromJson(Map<String, dynamic> json) =>
    _$ClinicImagesImpl(
      clinic_id: json['clinic_id'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ClinicImagesImplToJson(_$ClinicImagesImpl instance) =>
    <String, dynamic>{
      'clinic_id': instance.clinic_id,
      'images': instance.images,
    };
