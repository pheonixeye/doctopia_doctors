import 'package:doctopia_doctors/models/app_constants_model/_models/attendance_type.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/city.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/governorate.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/speciality.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/venue.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_location.dart';
import 'package:doctopia_doctors/models/clinic_response_model/schedule.dart';
import 'package:equatable/equatable.dart';

class Clinic extends Equatable {
  final String id;
  final String doc_id;
  final String name_en;
  final String name_ar;
  final String address_en;
  final String address_ar;
  final ClinicLocation location;
  final String mobile;
  final String landline;
  final int consultation_fees;
  final int followup_fees;
  final int followup_duration;
  final int discount;
  final Governorate governorate;
  final City city;
  final Speciality speciality;
  final AttendanceType attendance_type;
  final Venue? venue;
  final List<Schedule> schedule;
  final List<String> off_dates;

  const Clinic({
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
    required this.governorate,
    required this.city,
    required this.speciality,
    required this.attendance_type,
    required this.venue,
    required this.schedule,
    required this.off_dates,
  });

  Clinic copyWith({
    String? id,
    String? doc_id,
    String? name_en,
    String? name_ar,
    String? address_en,
    String? address_ar,
    ClinicLocation? location,
    String? mobile,
    String? landline,
    int? consultation_fees,
    int? followup_fees,
    int? followup_duration,
    int? discount,
    Governorate? governorate,
    City? city,
    Speciality? speciality,
    AttendanceType? attendance_type,
    Venue? venue,
    List<Schedule>? schedule,
    List<String>? off_dates,
  }) {
    return Clinic(
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
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      speciality: speciality ?? this.speciality,
      attendance_type: attendance_type ?? this.attendance_type,
      venue: venue ?? this.venue,
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
      'location': location.toJson(),
      'mobile': mobile,
      'landline': landline,
      'consultation_fees': consultation_fees,
      'followup_fees': followup_fees,
      'followup_duration': followup_duration,
      'discount': discount,
      'governorate': governorate.toJson(),
      'city': city.toJson(),
      'speciality': speciality.toJson(),
      'attendance_type': attendance_type.toJson(),
      'venue': venue?.toJson(),
      'schedule': schedule.map((e) => e.toJson()).toList(),
      'off_dates': off_dates,
    };
  }

  factory Clinic.fromJson(Map<String, dynamic> map) {
    return Clinic(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      address_en: map['address_en'] as String,
      address_ar: map['address_ar'] as String,
      location:
          ClinicLocation.fromJson(map['location'] as Map<String, dynamic>),
      mobile: map['mobile'] as String,
      landline: map['landline'] as String,
      consultation_fees: map['consultation_fees'] as int,
      followup_fees: map['followup_fees'] as int,
      followup_duration: map['followup_duration'] as int,
      discount: map['discount'] as int,
      governorate:
          Governorate.fromJson(map['governorate'] as Map<String, dynamic>),
      city: City.fromJson(map['city'] as Map<String, dynamic>),
      speciality:
          Speciality.fromJson(map['speciality'] as Map<String, dynamic>),
      attendance_type: AttendanceType.fromJson(
          map['attendance_type'] as Map<String, dynamic>),
      venue: map['venue'] != null
          ? Venue.fromJson(map['venue'] as Map<String, dynamic>)
          : null,
      schedule: (map['schedule'] as List<dynamic>)
          .map((e) => Schedule.fromJson(e))
          .toList(),
      off_dates: List<String>.from(map['off_dates'] as List<dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
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
      governorate,
      city,
      speciality,
      attendance_type,
      venue,
      schedule,
      off_dates,
    ];
  }
}
