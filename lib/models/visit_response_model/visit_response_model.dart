import 'package:equatable/equatable.dart';

class VisitResponseModel extends Equatable {
  final String id;
  final String patient_name;
  final String patient_phone;
  final String patient_email;
  final String doc_id;
  final String clinic_id;
  final String visit_type_id;
  final String visit_status_id;
  final String patient_id;
  final int day;
  final int month;
  final int year;
  final String visit_date;
  final Map<String, dynamic> visit_shift;
  final String created;

  const VisitResponseModel({
    required this.id,
    required this.patient_name,
    required this.patient_phone,
    required this.patient_email,
    required this.doc_id,
    required this.clinic_id,
    required this.visit_type_id,
    required this.visit_status_id,
    required this.patient_id,
    required this.day,
    required this.month,
    required this.year,
    required this.visit_date,
    required this.visit_shift,
    required this.created,
  });

  VisitResponseModel copyWith({
    String? id,
    String? patient_name,
    String? patient_phone,
    String? patient_email,
    String? doc_id,
    String? clinic_id,
    String? visit_type_id,
    String? visit_status_id,
    String? patient_id,
    int? day,
    int? month,
    int? year,
    String? visit_date,
    Map<String, dynamic>? visit_shift,
    String? created,
  }) {
    return VisitResponseModel(
      id: id ?? this.id,
      patient_name: patient_name ?? this.patient_name,
      patient_phone: patient_phone ?? this.patient_phone,
      patient_email: patient_email ?? this.patient_email,
      doc_id: doc_id ?? this.doc_id,
      clinic_id: clinic_id ?? this.clinic_id,
      visit_type_id: visit_type_id ?? this.visit_type_id,
      visit_status_id: visit_status_id ?? this.visit_status_id,
      patient_id: patient_id ?? this.patient_id,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      visit_date: visit_date ?? this.visit_date,
      visit_shift: visit_shift ?? this.visit_shift,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'patient_name': patient_name,
      'patient_phone': patient_phone,
      'patient_email': patient_email,
      'doc_id': doc_id,
      'clinic_id': clinic_id,
      'visit_type_id': visit_type_id,
      'visit_status_id': visit_status_id,
      'patient_id': patient_id,
      'day': day,
      'month': month,
      'year': year,
      'visit_date': visit_date,
      'visit_shift': visit_shift,
      'created': created,
    };
  }

  factory VisitResponseModel.fromJson(Map<String, dynamic> map) {
    return VisitResponseModel(
      id: map['id'] as String,
      patient_name: map['patient_name'] as String,
      patient_phone: map['patient_phone'] as String,
      patient_email: map['patient_email'] as String,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String,
      visit_type_id: map['visit_type_id'] as String,
      visit_status_id: map['visit_status_id'] as String,
      patient_id: map['patient_id'] as String,
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
      visit_date: map['visit_date'] as String,
      visit_shift: Map<String, dynamic>.from(
          (map['visit_shift'] as Map<String, dynamic>)),
      created: map['created'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      patient_name,
      patient_phone,
      patient_email,
      doc_id,
      clinic_id,
      visit_type_id,
      visit_status_id,
      patient_id,
      day,
      month,
      year,
      visit_date,
      visit_shift,
      created,
    ];
  }
}
