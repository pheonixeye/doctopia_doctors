import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/clinic_response_model/schedule.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ClinicResponseModel extends Equatable {
  final String id;
  final String doc_id;
  final String name_en;
  final String name_ar;
  final String address_en;
  final String address_ar;
  final Map<String, dynamic> location;
  final String mobile;
  final String landline;
  final int consultation_fees;
  final int followup_fees;
  final int followup_duration;
  final int discount;
  final String governorate_id;
  final String city_id;
  final String speciality_id;
  final String attendance_type_id;
  final String venue_id;
  final List<Map<String, dynamic>> schedule;
  final List<String> off_dates;

  const ClinicResponseModel({
    required this.id,
    required this.doc_id,
    required this.name_en,
    required this.name_ar,
    required this.address_en,
    required this.address_ar,
    required this.location,
    required this.mobile,
    required this.landline,
    required this.consultation_fees,
    required this.followup_fees,
    required this.followup_duration,
    required this.discount,
    required this.governorate_id,
    required this.city_id,
    required this.speciality_id,
    required this.attendance_type_id,
    required this.venue_id,
    required this.schedule,
    required this.off_dates,
  });

  ClinicResponseModel copyWith({
    String? id,
    String? doc_id,
    String? name_en,
    String? name_ar,
    String? address_en,
    String? address_ar,
    Map<String, dynamic>? location,
    String? mobile,
    String? landline,
    int? consultation_fees,
    int? followup_fees,
    int? followup_duration,
    int? discount,
    String? governorate_id,
    String? city_id,
    String? speciality_id,
    String? attendance_type_id,
    String? venue_id,
    List<Map<String, dynamic>>? schedule,
    List<String>? off_dates,
  }) {
    return ClinicResponseModel(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      address_en: address_en ?? this.address_en,
      address_ar: address_ar ?? this.address_ar,
      location: location ?? this.location,
      mobile: mobile ?? this.mobile,
      landline: landline ?? this.landline,
      consultation_fees: consultation_fees ?? this.consultation_fees,
      followup_fees: followup_fees ?? this.followup_fees,
      followup_duration: followup_duration ?? this.followup_duration,
      discount: discount ?? this.discount,
      governorate_id: governorate_id ?? this.governorate_id,
      city_id: city_id ?? this.city_id,
      speciality_id: speciality_id ?? this.speciality_id,
      attendance_type_id: attendance_type_id ?? this.attendance_type_id,
      venue_id: venue_id ?? this.venue_id,
      schedule: schedule ?? this.schedule,
      off_dates: off_dates ?? this.off_dates,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'name_en': name_en,
      'name_ar': name_ar,
      'address_en': address_en,
      'address_ar': address_ar,
      'location': location,
      'mobile': mobile,
      'landline': landline,
      'consultation_fees': consultation_fees,
      'followup_fees': followup_fees,
      'followup_duration': followup_duration,
      'discount': discount,
      'governorate_id': governorate_id,
      'city_id': city_id,
      'speciality_id': speciality_id,
      'attendance_type_id': attendance_type_id,
      'venue_id': venue_id,
      'schedule': schedule,
      'off_dates': off_dates,
    };
  }

  factory ClinicResponseModel.fromJson(Map<String, dynamic> map) {
    return ClinicResponseModel(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      address_en: map['address_en'] as String,
      address_ar: map['address_ar'] as String,
      location: map['location'] as Map<String, dynamic>,
      mobile: map['mobile'] as String,
      landline: map['landline'] as String,
      consultation_fees: map['consultation_fees'] as int,
      followup_fees: map['followup_fees'] as int,
      followup_duration: map['followup_duration'] as int,
      discount: map['discount'] as int,
      governorate_id: map['governorate_id'] as String,
      city_id: map['city_id'] as String,
      speciality_id: map['speciality_id'] as String,
      attendance_type_id: map['attendance_type_id'] as String,
      venue_id: map['venue_id'] as String,
      schedule:
          List<Map<String, dynamic>>.from((map['schedule'] as List<dynamic>)),
      off_dates: List<String>.from((map['off_dates'] as List<dynamic>)),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      name_en,
      name_ar,
      address_en,
      address_ar,
      location,
      mobile,
      landline,
      consultation_fees,
      followup_fees,
      followup_duration,
      discount,
      governorate_id,
      city_id,
      speciality_id,
      attendance_type_id,
      venue_id,
      schedule,
      off_dates,
    ];
  }

  factory ClinicResponseModel.initial() {
    return ClinicResponseModel(
      id: '',
      doc_id: '',
      name_en: '',
      name_ar: '',
      address_en: '',
      address_ar: '',
      location: {},
      mobile: '',
      landline: '',
      consultation_fees: 0,
      followup_fees: 0,
      followup_duration: 0,
      discount: 0,
      governorate_id: '',
      city_id: '',
      speciality_id: '',
      attendance_type_id: '',
      venue_id: '',
      schedule: Schedule.initialClinicSchedule.map((e) => e.toJson()).toList(),
      off_dates: const [],
    );
  }

  static Map<String, String> editableStrings(BuildContext context) => {
        "name_en": context.loc.engName,
        "name_ar": context.loc.arabicName,
        "mobile": context.loc.mobile,
        "landline": context.loc.landline,
        "address_en": context.loc.englishAddress,
        "address_ar": context.loc.arabicAddress,
        "consultation_fees": context.loc.consultationFees,
        "followup_fees": context.loc.followupFees,
        "followup_duration": context.loc.followupDuration,
        "discount": context.loc.discount,
      };

  static Map<String, String> editableDropdowns(BuildContext context) => {
        'governorate_id': context.loc.selectGov,
        'city_id': context.loc.selectArea,
        'attendance_type_id': context.loc.selectAtt,
      };
}
