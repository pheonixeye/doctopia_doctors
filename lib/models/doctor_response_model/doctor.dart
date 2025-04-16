import 'package:doctopia_doctors/models/app_constants_model/_models/degree.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/speciality.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor_response_model.dart';
import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String name_en;
  final String name_ar;
  final String title_en;
  final String title_ar;
  final String about_en;
  final String about_ar;
  final int synd_id;
  final String personal_phone;
  final DateTime joined_at;
  final bool published;
  final bool verified;
  final String avatar;
  final Speciality speciality;
  final Degree degree;

  const Doctor({
    required this.id,
    required this.name_en,
    required this.name_ar,
    required this.title_en,
    required this.title_ar,
    required this.about_en,
    required this.about_ar,
    required this.synd_id,
    required this.personal_phone,
    required this.joined_at,
    required this.published,
    required this.verified,
    required this.avatar,
    required this.speciality,
    required this.degree,
  });

  Doctor copyWith({
    String? id,
    String? name_en,
    String? name_ar,
    String? title_en,
    String? title_ar,
    String? about_en,
    String? about_ar,
    int? synd_id,
    String? personal_phone,
    DateTime? joined_at,
    bool? published,
    bool? verified,
    String? avatar,
    Speciality? speciality,
    Degree? degree,
  }) {
    return Doctor(
      id: id ?? this.id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      about_en: about_en ?? this.about_en,
      about_ar: about_ar ?? this.about_ar,
      synd_id: synd_id ?? this.synd_id,
      personal_phone: personal_phone ?? this.personal_phone,
      joined_at: joined_at ?? this.joined_at,
      published: published ?? this.published,
      verified: verified ?? this.verified,
      avatar: avatar ?? this.avatar,
      speciality: speciality ?? this.speciality,
      degree: degree ?? this.degree,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name_en': name_en,
      'name_ar': name_ar,
      'title_en': title_en,
      'title_ar': title_ar,
      'about_en': about_en,
      'about_ar': about_ar,
      'synd_id': synd_id,
      'personal_phone': personal_phone,
      'joined_at': joined_at.toIso8601String(),
      'published': published,
      'verified': verified,
      'avatar': avatar,
      'speciality': speciality.toJson(),
      'degree': degree.toJson(),
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      about_en: map['about_en'] as String,
      about_ar: map['about_ar'] as String,
      synd_id: map['synd_id'] as int,
      personal_phone: map['personal_phone'] as String,
      joined_at: DateTime.parse(map['joined_at'] as String),
      published: map['published'] as bool,
      verified: map['verified'] as bool,
      avatar: map['avatar'] as String,
      speciality:
          Speciality.fromJson(map['speciality'] as Map<String, dynamic>),
      degree: Degree.fromJson(map['degree'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name_en,
      name_ar,
      title_en,
      title_ar,
      about_en,
      about_ar,
      synd_id,
      personal_phone,
      joined_at,
      published,
      verified,
      avatar,
      speciality,
      degree,
    ];
  }

  factory Doctor.fromResponseModel({
    required DoctorResponseModel model,
    required Speciality? speciality,
    required Degree? degree,
  }) {
    return Doctor.fromJson({
      ...model.toJson(),
      'speciality': speciality?.toJson(),
      'degree': degree?.toJson(),
    });
  }
}
