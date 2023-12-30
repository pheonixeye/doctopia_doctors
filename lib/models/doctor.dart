// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final int synd_id;
  final String name_en;
  final String name_ar;
  final String personal_phone;
  final String assistant_phone;
  final String email;
  final String salt;
  final String password;
  final String avatar_link;
  final String speciality_en;
  final String speciality_ar;
  final bool published;
  final List<String> titles_en;
  final List<String> titles_ar;

  const Doctor({
    required this.id,
    required this.synd_id,
    required this.name_en,
    required this.name_ar,
    required this.personal_phone,
    required this.assistant_phone,
    required this.email,
    required this.salt,
    required this.password,
    required this.avatar_link,
    required this.speciality_en,
    required this.speciality_ar,
    required this.published,
    required this.titles_en,
    required this.titles_ar,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      synd_id: json['synd_id'],
      name_en: json['name_en'],
      name_ar: json['name_ar'],
      personal_phone: json['personal_phone'],
      assistant_phone: json['assistant_phone'],
      email: json['email'],
      salt: json['salt'],
      password: json['password'],
      avatar_link: json['avatar_link'],
      speciality_en: json['speciality_en'],
      speciality_ar: json['speciality_ar'],
      published: json['published'],
      titles_en: json['titles_en'],
      titles_ar: json['titles_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'synd_id': synd_id,
      'name_en': name_en,
      'name_ar': name_ar,
      'personal_phone': personal_phone,
      'assistant_phone': assistant_phone,
      'email': email,
      'salt': salt,
      'password': password,
      'avatar_link': avatar_link,
      'speciality_en': speciality_en,
      'speciality_ar': speciality_ar,
      'published': published,
      'titles_en': titles_en,
      'titles_ar': titles_ar,
    };
  }

  Doctor copyWith({
    String? id,
    int? synd_id,
    String? name_en,
    String? name_ar,
    String? personal_phone,
    String? assistant_phone,
    String? email,
    String? salt,
    String? password,
    String? avatar_link,
    String? speciality_en,
    String? speciality_ar,
    bool? published,
    List<String>? titles_en,
    List<String>? titles_ar,
  }) {
    return Doctor(
      id: id ?? this.id,
      synd_id: synd_id ?? this.synd_id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      personal_phone: personal_phone ?? this.personal_phone,
      assistant_phone: assistant_phone ?? this.assistant_phone,
      email: email ?? this.email,
      salt: salt ?? this.salt,
      password: password ?? this.password,
      avatar_link: avatar_link ?? this.avatar_link,
      speciality_en: speciality_en ?? this.speciality_en,
      speciality_ar: speciality_ar ?? this.speciality_ar,
      published: published ?? this.published,
      titles_en: titles_en ?? this.titles_en,
      titles_ar: titles_ar ?? this.titles_ar,
    );
  }

  @override
  List<Object?> get props => [
        id,
        synd_id,
        name_en,
        name_ar,
        personal_phone,
        assistant_phone,
        email,
        salt,
        password,
        avatar_link,
        speciality_en,
        speciality_ar,
        published,
        titles_en,
        titles_ar,
      ];
}
