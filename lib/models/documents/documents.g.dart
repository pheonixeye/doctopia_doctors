// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorDocumentsImpl _$$DoctorDocumentsImplFromJson(
        Map<String, dynamic> json) =>
    _$DoctorDocumentsImpl(
      docid: json['docid'] as String,
      synd_card: json['synd_card'] as String,
      permit_cert: json['permit_cert'] as String,
      specialist_cert: json['specialist_cert'] as String,
      consultant_cert: json['consultant_cert'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$$DoctorDocumentsImplToJson(
        _$DoctorDocumentsImpl instance) =>
    <String, dynamic>{
      'docid': instance.docid,
      'synd_card': instance.synd_card,
      'permit_cert': instance.permit_cert,
      'specialist_cert': instance.specialist_cert,
      'consultant_cert': instance.consultant_cert,
      'avatar': instance.avatar,
    };
