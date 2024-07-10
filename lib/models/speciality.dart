import 'package:equatable/equatable.dart';

class Speciality extends Equatable {
  final String en;
  final String ar;
  final String id;

  const Speciality({
    required this.en,
    required this.ar,
    required this.id,
  });

  Speciality copyWith({
    String? en,
    String? ar,
    String? id,
  }) {
    return Speciality(
      en: en ?? this.en,
      ar: ar ?? this.ar,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'speciality_en': en,
      'speciality_ar': ar,
    };
  }

  factory Speciality.fromJson(Map<String, dynamic> map) {
    return Speciality(
      id: map['id'] as String,
      en: map['speciality_en'] as String,
      ar: map['speciality_ar'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [en, ar, id];
}
