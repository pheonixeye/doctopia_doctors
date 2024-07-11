// ignore_for_file:  non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String doc_id;
  final String user_name;
  final String body;
  final String date_time;
  final int waiting_time;
  final int stars;
  const Review({
    required this.id,
    required this.doc_id,
    required this.user_name,
    required this.body,
    required this.date_time,
    required this.waiting_time,
    required this.stars,
  });

  Review copyWith({
    String? id,
    String? doc_id,
    String? user_name,
    String? body,
    String? date_time,
    int? waiting_time,
    int? stars,
  }) {
    return Review(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      user_name: user_name ?? this.user_name,
      body: body ?? this.body,
      date_time: date_time ?? this.date_time,
      waiting_time: waiting_time ?? this.waiting_time,
      stars: stars ?? this.stars,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'user_name': user_name,
      'body': body,
      'date_time': date_time,
      'waiting_time': waiting_time,
      'stars': stars,
    };
  }

  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      user_name: map['user_name'] as String,
      body: map['body'] as String,
      date_time: map['date_time'] as String,
      waiting_time: map['waiting_time'] as int,
      stars: map['stars'] as int,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      user_name,
      body,
      date_time,
      waiting_time,
      stars,
    ];
  }
}
