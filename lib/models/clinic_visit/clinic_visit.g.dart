// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicVisitImpl _$$ClinicVisitImplFromJson(Map<String, dynamic> json) =>
    _$ClinicVisitImpl(
      id: json['id'] as String,
      pt_name: json['pt_name'] as String,
      pt_phone: json['pt_phone'] as String,
      doc_id: json['doc_id'] as String,
      clinic_id: json['clinic_id'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$ClinicVisitImplToJson(_$ClinicVisitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pt_name': instance.pt_name,
      'pt_phone': instance.pt_phone,
      'doc_id': instance.doc_id,
      'clinic_id': instance.clinic_id,
      'date': instance.date,
    };
