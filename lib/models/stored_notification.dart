// ignore_for_file:  non_constant_identifier_names

import 'package:equatable/equatable.dart';

class StoredNotification extends Equatable {
  final String id;
  final String doc_id;
  final String title;
  final String? body;
  final bool seen;
  final Map<String, dynamic> data;

  const StoredNotification({
    required this.id,
    required this.doc_id,
    required this.title,
    this.body,
    required this.seen,
    required this.data,
  });

  StoredNotification copyWith({
    String? id,
    String? doc_id,
    String? title,
    String? body,
    bool? seen,
    Map<String, dynamic>? data,
  }) {
    return StoredNotification(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      title: title ?? this.title,
      body: body ?? this.body,
      seen: seen ?? this.seen,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'title': title,
      'body': body,
      'seen': seen,
      'data': data,
    };
  }

  factory StoredNotification.fromJson(Map<String, dynamic> map) {
    return StoredNotification(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      title: map['title'] as String,
      body: map['body'] as String?,
      seen: map['seen'] as bool,
      data: Map<String, dynamic>.from(
        (map['data'] as Map<String, dynamic>),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      title,
      body,
      seen,
      data,
    ];
  }
}
