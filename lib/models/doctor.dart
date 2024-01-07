// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final int synd_id;
  final String joined_at;
  final String name_en;
  final String name_ar;
  final String personal_phone;
  final String assistant_phone;
  final String email;
  final String salt;
  final String password;
  final String speciality_en;
  final String speciality_ar;
  final bool published;
  final List<String> titles_en;
  final List<String> titles_ar;
  final String about_en;
  final String about_ar;
  final String degree_en;
  final String degree_ar;

  const Doctor({
    required this.id,
    required this.synd_id,
    required this.joined_at,
    required this.name_en,
    required this.name_ar,
    required this.personal_phone,
    required this.assistant_phone,
    required this.email,
    required this.salt,
    required this.password,
    required this.speciality_en,
    required this.speciality_ar,
    required this.published,
    required this.titles_en,
    required this.titles_ar,
    required this.about_en,
    required this.about_ar,
    required this.degree_en,
    required this.degree_ar,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json[r'$id'],
      synd_id: json['synd_id'],
      joined_at: json['joined_at'],
      name_en: json['name_en'],
      name_ar: json['name_ar'],
      personal_phone: json['personal_phone'],
      assistant_phone: json['assistant_phone'],
      email: json['email'],
      salt: json['salt'],
      password: json['password'],
      speciality_en: json['speciality_en'],
      speciality_ar: json['speciality_ar'],
      published: json['published'],
      titles_en: json['titles_en'],
      titles_ar: json['titles_ar'],
      about_en: json['about_en'],
      about_ar: json['about_ar'],
      degree_en: json['degree_en'],
      degree_ar: json['degree_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'$id': id,
      'synd_id': synd_id,
      "joined_at": joined_at,
      'name_en': name_en,
      'name_ar': name_ar,
      'personal_phone': personal_phone,
      'assistant_phone': assistant_phone,
      'email': email,
      'salt': salt,
      'password': password,
      'speciality_en': speciality_en,
      'speciality_ar': speciality_ar,
      'published': published,
      'titles_en': titles_en,
      'titles_ar': titles_ar,
      "about_en": about_en,
      "about_ar": about_ar,
      "degree_en": degree_en,
      "degree_ar": degree_ar,
    };
  }

  Doctor copyWith({
    String? id,
    int? synd_id,
    String? joined_at,
    String? name_en,
    String? name_ar,
    String? personal_phone,
    String? assistant_phone,
    String? email,
    String? salt,
    String? password,
    String? speciality_en,
    String? speciality_ar,
    bool? published,
    List<String>? titles_en,
    List<String>? titles_ar,
    String? about_en,
    String? about_ar,
    String? degree_en,
    String? degree_ar,
  }) {
    return Doctor(
      id: id ?? this.id,
      synd_id: synd_id ?? this.synd_id,
      joined_at: joined_at ?? this.joined_at,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      personal_phone: personal_phone ?? this.personal_phone,
      assistant_phone: assistant_phone ?? this.assistant_phone,
      email: email ?? this.email,
      salt: salt ?? this.salt,
      password: password ?? this.password,
      speciality_en: speciality_en ?? this.speciality_en,
      speciality_ar: speciality_ar ?? this.speciality_ar,
      published: published ?? this.published,
      titles_en: titles_en ?? this.titles_en,
      titles_ar: titles_ar ?? this.titles_ar,
      about_en: about_en ?? this.about_en,
      about_ar: about_ar ?? this.about_ar,
      degree_en: degree_en ?? this.degree_en,
      degree_ar: degree_ar ?? this.degree_ar,
    );
  }

  @override
  List<Object?> get props => [
        id,
        synd_id,
        joined_at,
        name_en,
        name_ar,
        personal_phone,
        assistant_phone,
        email,
        salt,
        password,
        speciality_en,
        speciality_ar,
        published,
        titles_en,
        titles_ar,
        about_en,
        about_ar,
        degree_en,
        degree_ar,
      ];
}
