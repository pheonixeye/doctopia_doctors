// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/models/destination.dart';
import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final int synd_id;
  final String joined_at;
  final String name_en;
  final String name_ar;
  final String personal_phone;
  final String speciality_en;
  final String speciality_ar;
  final bool published;
  final String title_en;
  final String title_ar;
  final String about_en;
  final String about_ar;
  final String degree_en;
  final String degree_ar;
  final double rating;
  final List<String> tags;
  final int views;
  final List<Destination> destinations;
  final String? avatar;

  const Doctor({
    required this.id,
    required this.synd_id,
    required this.joined_at,
    required this.name_en,
    required this.name_ar,
    required this.personal_phone,
    required this.speciality_en,
    required this.speciality_ar,
    required this.published,
    required this.title_en,
    required this.title_ar,
    required this.about_en,
    required this.about_ar,
    required this.degree_en,
    required this.degree_ar,
    required this.rating,
    required this.tags,
    required this.views,
    required this.destinations,
    this.avatar,
  });

  Doctor copyWith({
    String? id,
    int? synd_id,
    String? joined_at,
    String? name_en,
    String? name_ar,
    String? personal_phone,
    String? speciality_en,
    String? speciality_ar,
    bool? published,
    String? title_en,
    String? title_ar,
    String? about_en,
    String? about_ar,
    String? degree_en,
    String? degree_ar,
    double? rating,
    List<String>? tags,
    int? views,
    List<Destination>? destinations,
    String? avatar,
  }) {
    return Doctor(
      id: id ?? this.id,
      synd_id: synd_id ?? this.synd_id,
      joined_at: joined_at ?? this.joined_at,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      personal_phone: personal_phone ?? this.personal_phone,
      speciality_en: speciality_en ?? this.speciality_en,
      speciality_ar: speciality_ar ?? this.speciality_ar,
      published: published ?? this.published,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      about_en: about_en ?? this.about_en,
      about_ar: about_ar ?? this.about_ar,
      degree_en: degree_en ?? this.degree_en,
      degree_ar: degree_ar ?? this.degree_ar,
      rating: rating ?? this.rating,
      tags: tags ?? this.tags,
      views: views ?? this.views,
      destinations: destinations ?? this.destinations,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'synd_id': synd_id,
      'joined_at': joined_at,
      'name_en': name_en,
      'name_ar': name_ar,
      'personal_phone': personal_phone,
      'speciality_en': speciality_en,
      'speciality_ar': speciality_ar,
      'published': published,
      'title_en': title_en,
      'title_ar': title_ar,
      'about_en': about_en,
      'about_ar': about_ar,
      'degree_en': degree_en,
      'degree_ar': degree_ar,
      'rating': rating,
      'tags': tags,
      'views': views,
      'destinations': destinations.map((e) => e.toJson()).toList(),
      'avatar': avatar,
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as String,
      synd_id: map['synd_id'] as int,
      joined_at: map['joined_at'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      personal_phone: map['personal_phone'] as String,
      speciality_en: map['speciality_en'] as String,
      speciality_ar: map['speciality_ar'] as String,
      published: map['published'] as bool,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      about_en: map['about_en'] as String,
      about_ar: map['about_ar'] as String,
      degree_en: map['degree_en'] as String,
      degree_ar: map['degree_ar'] as String,
      rating: map['rating'] as double,
      tags: List<String>.from((map['tags'] as List<dynamic>)),
      views: map['views'] as int,
      destinations: (map['destinations'] as List)
          .map((e) => Destination.fromJson(e))
          .toList(),
      avatar: map['avatar'] as String?,
    );
  }

  factory Doctor.emptyForCreate() {
    return const Doctor(
      id: '',
      synd_id: 0,
      joined_at: '',
      name_en: '',
      name_ar: '',
      personal_phone: '',
      speciality_en: '',
      speciality_ar: '',
      published: false,
      title_en: '',
      title_ar: '',
      about_en: '',
      about_ar: '',
      degree_en: '',
      degree_ar: '',
      rating: 0,
      tags: [],
      views: 0,
      destinations: [],
      avatar: null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      synd_id,
      joined_at,
      name_en,
      name_ar,
      personal_phone,
      speciality_en,
      speciality_ar,
      published,
      title_en,
      title_ar,
      about_en,
      about_ar,
      degree_en,
      degree_ar,
      rating,
      tags,
      views,
      destinations,
      avatar,
    ];
  }
}
