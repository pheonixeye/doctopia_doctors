import 'package:doctopia_doctors/models/msg.dart';
import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  final NotMsg notMsg;
  final Map<String, dynamic> data;
  final bool seen;

  const AppNotification({
    required this.notMsg,
    required this.data,
    required this.seen,
  });

  AppNotification copyWith({
    NotMsg? notMsg,
    Map<String, dynamic>? data,
    bool? seen,
  }) {
    return AppNotification(
      notMsg: notMsg ?? this.notMsg,
      data: data ?? this.data,
      seen: seen ?? this.seen,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'notMsg': notMsg.toJson(),
      'data': data,
      'seen': seen,
    };
  }

  factory AppNotification.fromJson(Map<String, dynamic> map) {
    return AppNotification(
      notMsg: NotMsg.fromJson(map['notMsg'] as Map<String, dynamic>),
      data: Map<String, dynamic>.from(
        (map['data'] as Map<String, dynamic>),
      ),
      seen: map['seen'] as bool,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [notMsg, data];
}
