// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ClinicVisit extends Equatable {
  final String id;
  final String user_name;
  final String user_phone;
  final String? user_email;
  final String doc_id;
  final String clinic_id;
  final String date_time;
  final String? type;
  final bool attended;
  final int day;
  final int month;
  final int year;

  const ClinicVisit({
    required this.id,
    required this.user_name,
    required this.user_phone,
    this.user_email,
    required this.doc_id,
    required this.clinic_id,
    required this.date_time,
    this.type,
    required this.attended,
    required this.day,
    required this.month,
    required this.year,
  });

  ClinicVisit copyWith({
    String? id,
    String? user_name,
    String? user_phone,
    String? user_email,
    String? doc_id,
    String? clinic_id,
    String? date_time,
    String? type,
    bool? attended,
    int? day,
    int? month,
    int? year,
  }) {
    return ClinicVisit(
      id: id ?? this.id,
      user_name: user_name ?? this.user_name,
      user_phone: user_phone ?? this.user_phone,
      user_email: user_email ?? this.user_email,
      doc_id: doc_id ?? this.doc_id,
      clinic_id: clinic_id ?? this.clinic_id,
      date_time: date_time ?? this.date_time,
      type: type ?? this.type,
      attended: attended ?? this.attended,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_name': user_name,
      'user_phone': user_phone,
      'user_email': user_email,
      'doc_id': doc_id,
      'clinic_id': clinic_id,
      'date_time': date_time,
      'type': type,
      'attended': attended,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory ClinicVisit.fromJson(Map<String, dynamic> map) {
    return ClinicVisit(
      id: map['id'] as String,
      user_name: map['user_name'] as String,
      user_phone: map['user_phone'] as String,
      user_email: map['user_email'] as String?,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String,
      date_time: map['date_time'] as String,
      type: map['type'] as String?,
      attended: map['attended'] as bool,
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      user_name,
      user_phone,
      user_email,
      doc_id,
      clinic_id,
      date_time,
      type,
      attended,
      day,
      month,
      year,
    ];
  }
}
