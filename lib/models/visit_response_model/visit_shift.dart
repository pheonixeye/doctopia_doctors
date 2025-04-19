import 'package:equatable/equatable.dart';

class VisitShift extends Equatable {
  final String id;
  final int start_hour;
  final int start_minute;
  final int end_hour;
  final int end_minute;

  const VisitShift({
    required this.id,
    required this.start_hour,
    required this.start_minute,
    required this.end_hour,
    required this.end_minute,
  });

  VisitShift copyWith({
    String? id,
    int? start_hour,
    int? start_minute,
    int? end_hour,
    int? end_minute,
  }) {
    return VisitShift(
      id: id ?? this.id,
      start_hour: start_hour ?? this.start_hour,
      start_minute: start_minute ?? this.start_minute,
      end_hour: end_hour ?? this.end_hour,
      end_minute: end_minute ?? this.end_minute,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'start_hour': start_hour,
      'start_minute': start_minute,
      'end_hour': end_hour,
      'end_minute': end_minute,
    };
  }

  factory VisitShift.fromJson(Map<String, dynamic> map) {
    return VisitShift(
      id: map['id'] as String,
      start_hour: map['start_hour'] as int,
      start_minute: map['start_minute'] as int,
      end_hour: map['end_hour'] as int,
      end_minute: map['end_minute'] as int,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      start_hour,
      start_minute,
      end_hour,
      end_minute,
    ];
  }
}
