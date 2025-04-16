import 'package:equatable/equatable.dart';

class DoctorResponseModel extends Equatable {
  final String id;
  final String name_en;
  final String name_ar;
  final String title_en;
  final String title_ar;
  final String about_en;
  final String about_ar;
  final int synd_id;
  final String personal_phone;
  final String joined_at;
  final bool published;
  final bool verified;
  final String avatar;
  final String speciality_id;
  final String degree_id;

  const DoctorResponseModel({
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
    required this.speciality_id,
    required this.degree_id,
  });

  DoctorResponseModel copyWith({
    String? id,
    String? name_en,
    String? name_ar,
    String? title_en,
    String? title_ar,
    String? about_en,
    String? about_ar,
    int? synd_id,
    String? personal_phone,
    String? joined_at,
    bool? published,
    bool? verified,
    String? avatar,
    String? speciality_id,
    String? degree_id,
  }) {
    return DoctorResponseModel(
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
      speciality_id: speciality_id ?? this.speciality_id,
      degree_id: degree_id ?? this.degree_id,
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
      'joined_at': joined_at,
      'published': published,
      'verified': verified,
      'avatar': avatar,
      'speciality_id': speciality_id,
      'degree_id': degree_id,
    };
  }

  factory DoctorResponseModel.fromJson(Map<String, dynamic> map) {
    return DoctorResponseModel(
      id: map['id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      about_en: map['about_en'] as String,
      about_ar: map['about_ar'] as String,
      synd_id: map['synd_id'] as int,
      personal_phone: map['personal_phone'] as String,
      joined_at: map['joined_at'] as String,
      published: map['published'] as bool,
      verified: map['verified'] as bool,
      avatar: map['avatar'] as String,
      speciality_id: map['speciality_id'] as String,
      degree_id: map['degree_id'] as String,
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
      speciality_id,
      degree_id,
    ];
  }

  factory DoctorResponseModel.initial() {
    return DoctorResponseModel(
      id: '',
      name_en: '',
      name_ar: '',
      title_en: '',
      title_ar: '',
      about_en: '',
      about_ar: '',
      synd_id: 0,
      personal_phone: '',
      joined_at: DateTime.now().toIso8601String(),
      published: false,
      verified: false,
      avatar: '',
      speciality_id: '',
      degree_id: '',
    );
  }
}
