import 'package:equatable/equatable.dart';

class NotMsg extends Equatable {
  final String id;
  final String title;
  final String body;

  const NotMsg({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];

  @override
  bool? get stringify => true;

  NotMsg copyWith({
    String? id,
    String? title,
    String? body,
  }) {
    return NotMsg(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory NotMsg.fromJson(Map<String, dynamic> map) {
    return NotMsg(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }
}
