import 'dart:convert';

import 'package:doctopia_doctors/api/constant/weekdays.dart';
import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String id;
  final String weekday;
  final int intday;
  final int startMin;
  final int startHour;
  final int endMin;
  final int endHour;
  final bool available;

  const Schedule({
    required this.id,
    required this.weekday,
    required this.intday,
    required this.startMin,
    required this.startHour,
    required this.endMin,
    required this.endHour,
    required this.available,
  });

  Schedule copyWith(
      {String? id,
      String? weekday,
      int? intday,
      int? startMin,
      int? startHour,
      int? endMin,
      int? endHour,
      bool? available}) {
    return Schedule(
      id: id ?? this.id,
      weekday: weekday ?? this.weekday,
      intday: intday ?? this.intday,
      startMin: startMin ?? this.startMin,
      startHour: startHour ?? this.startHour,
      endMin: endMin ?? this.endMin,
      endHour: endHour ?? this.endHour,
      available: available ?? this.available,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'weekday': weekday,
      'intday': intday,
      'startMin': startMin,
      'startHour': startHour,
      'endMin': endMin,
      'endHour': endHour,
      'available': available,
    };
  }

  static List<Schedule> listFromPocketbase(String data) {
    final List json = jsonDecode(data);
    return json.map((e) => Schedule.fromJson(e)).toList();
  }

  factory Schedule.fromJson(Map<String, dynamic> map) {
    return Schedule(
      id: map['_id'] as String,
      weekday: map['weekday'] as String,
      intday: map['intday'] as int,
      startMin: map['startMin'] as int,
      startHour: map['startHour'] as int,
      endMin: map['endMin'] as int,
      endHour: map['endHour'] as int,
      available: map['available'] as bool,
    );
  }

  factory Schedule.initial() {
    return const Schedule(
      id: "1",
      weekday: "Monday",
      intday: 1,
      startMin: 0,
      startHour: 0,
      endMin: 0,
      endHour: 0,
      available: false,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      weekday,
      intday,
      startMin,
      startHour,
      endMin,
      endHour,
      available,
    ];
  }

  static final List<Schedule> initialClinicSchedule = [
    ...WEEKDAYS.entries
        .map((e) => Schedule(
              id: "${e.key}",
              weekday: e.value.en,
              intday: e.value.d,
              startMin: 0,
              startHour: 0,
              endMin: 0,
              endHour: 0,
              available: false,
            ))
        .toList(),
  ];
}
