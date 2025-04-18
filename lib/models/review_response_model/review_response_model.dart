import 'package:equatable/equatable.dart';

class ReviewResponseModel extends Equatable {
  final String id;
  final String doc_id;
  final String clinic_id;
  final String visit_id;
  final String patient_id;
  final String review_status_id;
  final String review;
  final int stars;
  final int waiting_time;
  final String patient_name;
  final String patient_phone;
  final String patient_email;
  final String created;

  const ReviewResponseModel({
    required this.id,
    required this.doc_id,
    required this.clinic_id,
    required this.visit_id,
    required this.patient_id,
    required this.review_status_id,
    required this.review,
    required this.stars,
    required this.waiting_time,
    required this.patient_name,
    required this.patient_phone,
    required this.patient_email,
    required this.created,
  });

  ReviewResponseModel copyWith({
    String? id,
    String? doc_id,
    String? clinic_id,
    String? visit_id,
    String? patient_id,
    String? review_status_id,
    String? review,
    int? stars,
    int? waiting_time,
    String? patient_name,
    String? patient_phone,
    String? patient_email,
    String? created,
  }) {
    return ReviewResponseModel(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      clinic_id: clinic_id ?? this.clinic_id,
      visit_id: visit_id ?? this.visit_id,
      patient_id: patient_id ?? this.patient_id,
      review_status_id: review_status_id ?? this.review_status_id,
      review: review ?? this.review,
      stars: stars ?? this.stars,
      waiting_time: waiting_time ?? this.waiting_time,
      patient_name: patient_name ?? this.patient_name,
      patient_phone: patient_phone ?? this.patient_phone,
      patient_email: patient_email ?? this.patient_email,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'clinic_id': clinic_id,
      'visit_id': visit_id,
      'patient_id': patient_id,
      'review_status_id': review_status_id,
      'review': review,
      'stars': stars,
      'waiting_time': waiting_time,
      'patient_name': patient_name,
      'patient_phone': patient_phone,
      'patient_email': patient_email,
      'created': created,
    };
  }

  factory ReviewResponseModel.fromJson(Map<String, dynamic> map) {
    return ReviewResponseModel(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String,
      visit_id: map['visit_id'] as String,
      patient_id: map['patient_id'] as String,
      review_status_id: map['review_status_id'] as String,
      review: map['review'] as String,
      stars: map['stars'] as int,
      waiting_time: map['waiting_time'] as int,
      patient_name: map['patient_name'] as String,
      patient_phone: map['patient_phone'] as String,
      patient_email: map['patient_email'] as String,
      created: map['created'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      clinic_id,
      visit_id,
      patient_id,
      review_status_id,
      review,
      stars,
      waiting_time,
      patient_name,
      patient_phone,
      patient_email,
      created,
    ];
  }
}
