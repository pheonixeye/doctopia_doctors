import 'package:doctopia_doctors/models/app_constants_model/_models/review_status.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String doc_id;
  final String clinic_id;
  final String visit_id;
  final String patient_id;
  final ReviewStatus review_status;
  final String review;
  final int stars;
  final int waiting_time;
  final String patient_name;
  final String patient_phone;
  final String patient_email;
  final String created;

  const Review({
    required this.id,
    required this.doc_id,
    required this.clinic_id,
    required this.visit_id,
    required this.patient_id,
    required this.review_status,
    required this.review,
    required this.stars,
    required this.waiting_time,
    required this.patient_name,
    required this.patient_phone,
    required this.patient_email,
    required this.created,
  });

  Review copyWith({
    String? id,
    String? doc_id,
    String? clinic_id,
    String? visit_id,
    String? patient_id,
    ReviewStatus? review_status,
    String? review,
    int? stars,
    int? waiting_time,
    String? patient_name,
    String? patient_phone,
    String? patient_email,
    String? created,
  }) {
    return Review(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      clinic_id: clinic_id ?? this.clinic_id,
      visit_id: visit_id ?? this.visit_id,
      patient_id: patient_id ?? this.patient_id,
      review_status: review_status ?? this.review_status,
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
      'review_status': review_status.toJson(),
      'review': review,
      'stars': stars,
      'waiting_time': waiting_time,
      'patient_name': patient_name,
      'patient_phone': patient_phone,
      'patient_email': patient_email,
      'created': created,
    };
  }

  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String,
      visit_id: map['visit_id'] as String,
      patient_id: map['patient_id'] as String,
      review_status:
          ReviewStatus.fromJson(map['review_status'] as Map<String, dynamic>),
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
      review_status,
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
