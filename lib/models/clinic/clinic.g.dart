// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicImpl _$$ClinicImplFromJson(Map<String, dynamic> json) => _$ClinicImpl(
      doc_id: json['doc_id'] as String,
      speciality_en: json['speciality_en'] as String,
      speciality_ar: json['speciality_ar'] as String,
      name_en: json['name_en'] as String,
      name_ar: json['name_ar'] as String,
      venue_en: json['venue_en'] as String,
      venue_ar: json['venue_ar'] as String,
      gov_en: json['gov_en'] as String,
      gov_ar: json['gov_ar'] as String,
      city_en: json['city_en'] as String,
      city_ar: json['city_ar'] as String,
      mobile: json['mobile'] as String,
      landline: json['landline'] as String,
      address_en: json['address_en'] as String,
      address_ar: json['address_ar'] as String,
      location_link: json['location_link'] as String,
      attendance: json['attendance'] as bool,
      published: json['published'] as bool,
      fees: json['fees'] as int,
      discount: json['discount'] as int,
      off_dates:
          (json['off_dates'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ClinicImplToJson(_$ClinicImpl instance) =>
    <String, dynamic>{
      'doc_id': instance.doc_id,
      'speciality_en': instance.speciality_en,
      'speciality_ar': instance.speciality_ar,
      'name_en': instance.name_en,
      'name_ar': instance.name_ar,
      'venue_en': instance.venue_en,
      'venue_ar': instance.venue_ar,
      'gov_en': instance.gov_en,
      'gov_ar': instance.gov_ar,
      'city_en': instance.city_en,
      'city_ar': instance.city_ar,
      'mobile': instance.mobile,
      'landline': instance.landline,
      'address_en': instance.address_en,
      'address_ar': instance.address_ar,
      'location_link': instance.location_link,
      'attendance': instance.attendance,
      'published': instance.published,
      'fees': instance.fees,
      'discount': instance.discount,
      'off_dates': instance.off_dates,
    };
