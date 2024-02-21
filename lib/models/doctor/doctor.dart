// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/functions/list_d_list_s.dart';
import 'package:doctopia_doctors/models/translatable/translatable.dart';
import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String? id;
  final int synd_id;
  final String joined_at;
  final String name_en;
  final String name_ar;
  final String personal_phone;
  final String assistant_phone;
  final String email;
  final String salt;
  final String password;
  final int? spec_id;
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
    this.id,
    required this.synd_id,
    required this.joined_at,
    required this.name_en,
    required this.name_ar,
    required this.personal_phone,
    required this.assistant_phone,
    required this.email,
    required this.salt,
    required this.password,
    required this.spec_id,
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

  static const Map<String, Type> scheme = {
    'synd_id': int,
    "joined_at": String,
    'name_en': String,
    'name_ar': String,
    'personal_phone': String,
    'assistant_phone': String,
    'email': String,
    'salt': String,
    'password': String,
    'spec_id': int,
    'speciality_en': String,
    'speciality_ar': String,
    'published': bool,
    'titles_en': List<String>,
    'titles_ar': List<String>,
    "about_en": String,
    "about_ar": String,
    "degree_en": String,
    "degree_ar": String,
  };

  static const Map<String, ModelTranslatable> _forWidgets = {
    'synd_id': ModelTranslatable(en: 'Syndicate Id', ar: "رقم القيد بالنقابة"),
    "joined_at":
        ModelTranslatable(en: 'Registeration Date', ar: 'تاريخ التسجيل'),
    'name_en': ModelTranslatable(en: 'English Name', ar: "الاسم بالانجليزية"),
    'name_ar': ModelTranslatable(en: 'Arabic Name', ar: "الاسم بالعربية"),
    'personal_phone':
        ModelTranslatable(en: 'Personal Phone', ar: "الرقم الشخصي"),
    'assistant_phone':
        ModelTranslatable(en: 'Assistant Phone', ar: "رقم السكيرتارية"),
    'email': ModelTranslatable(en: 'Email', ar: "البريد الالكتروني"),
    'salt': ModelTranslatable.X,
    'password': ModelTranslatable(en: 'Password', ar: "كلمة السر"),
    'speciality_en': ModelTranslatable(
        en: 'Speciality in English', ar: "التخصص بالانجليزية"),
    'speciality_ar':
        ModelTranslatable(en: 'Speciality in Arabic', ar: "التخصص بالعربية"),
    'published': ModelTranslatable(en: 'Published', ar: "النشر"),
    'titles_en':
        ModelTranslatable(en: 'English Titles', ar: "الالقاب بالانجليزية"),
    'titles_ar': ModelTranslatable(en: 'Arabic Titles', ar: "الالقاب بالعربية"),
    "about_en":
        ModelTranslatable(en: 'About in English', ar: "نبذة بالانجليزية"),
    "about_ar": ModelTranslatable(en: 'About in Arabic', ar: "نبذة بالعربية"),
    "degree_en":
        ModelTranslatable(en: 'English Degree', ar: "الدرجة بالانجليزية"),
    "degree_ar": ModelTranslatable(en: 'Arabic Degree', ar: "الدرجة بالعربية"),
  };

  static String keyToWidget(String key, bool isEnglish) {
    return isEnglish ? _forWidgets[key]!.en : _forWidgets[key]!.ar;
  }

  static const List<String> editableFieldAttributes = [
    'name_en',
    'name_ar',
    'personal_phone',
    'assistant_phone',
    'email',
    'about_en',
    'about_ar',
  ];
  static const List<String> editableListAttributes = [
    'titles_en',
    'titles_ar',
  ];
  static const List<String> editableDropdownAttributes = [
    'degree_en',
    'speciality_en',
  ];
  static const List<String> nonEditableAttributes = [
    'synd_id',
    'joined_at',
  ];

  factory Doctor.initial() {
    return Doctor(
      synd_id: 0,
      name_en: '',
      name_ar: '',
      personal_phone: '',
      assistant_phone: '',
      email: '',
      salt: '',
      password: '',
      spec_id: null,
      speciality_en: '',
      speciality_ar: '',
      about_en: '',
      about_ar: '',
      degree_en: '',
      degree_ar: '',
      joined_at: DateTime.now().toIso8601String(),
      published: false,
      titles_en: const <String>[],
      titles_ar: const <String>[],
    );
  }

  factory Doctor.fromJson(Map<String, dynamic> json, {String? id}) {
    return Doctor(
      id: id,
      synd_id: json['synd_id'],
      joined_at: json['joined_at'],
      name_en: json['name_en'],
      name_ar: json['name_ar'],
      personal_phone: json['personal_phone'],
      assistant_phone: json['assistant_phone'],
      email: json['email'],
      salt: json['salt'],
      password: json['password'],
      spec_id: json['spec_id'],
      speciality_en: json['speciality_en'],
      speciality_ar: json['speciality_ar'],
      published: json['published'],
      titles_en: stringListFns(json['titles_en']),
      titles_ar: stringListFns(json['titles_ar']),
      about_en: json['about_en'],
      about_ar: json['about_ar'],
      degree_en: json['degree_en'],
      degree_ar: json['degree_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'synd_id': synd_id,
      "joined_at": joined_at,
      'name_en': name_en,
      'name_ar': name_ar,
      'personal_phone': personal_phone,
      'assistant_phone': assistant_phone,
      'email': email,
      "about_en": about_en,
      "about_ar": about_ar,
      'titles_en': titles_en,
      'titles_ar': titles_ar,
      'spec_id': spec_id,
      'speciality_en': speciality_en,
      'speciality_ar': speciality_ar,
      "degree_en": degree_en,
      "degree_ar": degree_ar,
      'salt': salt,
      'password': password,
      'published': published,
    };
  }

  Doctor copyWith({
    int? synd_id,
    String? joined_at,
    String? name_en,
    String? name_ar,
    String? personal_phone,
    String? assistant_phone,
    String? email,
    String? salt,
    String? password,
    int? spec_id,
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
      synd_id: synd_id ?? this.synd_id,
      joined_at: joined_at ?? this.joined_at,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      personal_phone: personal_phone ?? this.personal_phone,
      assistant_phone: assistant_phone ?? this.assistant_phone,
      email: email ?? this.email,
      salt: salt ?? this.salt,
      password: password ?? this.password,
      spec_id: spec_id ?? this.spec_id,
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
        synd_id,
        joined_at,
        name_en,
        name_ar,
        personal_phone,
        assistant_phone,
        email,
        salt,
        password,
        spec_id,
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
