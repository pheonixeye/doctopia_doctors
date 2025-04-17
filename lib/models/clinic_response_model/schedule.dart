import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:proklinik_models/models/clinic_shift.dart';
import 'package:proklinik_models/models/weekdays.dart';

class Schedule extends Equatable {
  final String id;
  final String weekday;
  final int intday;
  final bool available;
  final List<ClinicShift> shifts;

  const Schedule({
    required this.id,
    required this.weekday,
    required this.intday,
    required this.available,
    required this.shifts,
  });

  Schedule copyWith({
    String? id,
    String? weekday,
    int? intday,
    bool? available,
    List<ClinicShift>? shifts,
  }) {
    return Schedule(
      id: id ?? this.id,
      weekday: weekday ?? this.weekday,
      intday: intday ?? this.intday,
      available: available ?? this.available,
      shifts: shifts ?? this.shifts,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'weekday': weekday,
      'intday': intday,
      'available': available,
      'shifts': shifts.map((e) => e.toJson()).toList()
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
      available: map['available'] as bool,
      shifts: (map['shifts'] as List<dynamic>)
          .map((e) => ClinicShift.fromJson(e))
          .toList(),
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
      available,
      shifts,
    ];
  }

  static final List<Schedule> initialClinicSchedule = [
    ...WEEKDAYS.entries.map(
      (e) => Schedule(
        id: "${e.key}",
        weekday: e.value.en,
        intday: e.value.d,
        available: false,
        shifts: [],
      ),
    ),
  ];

  factory Schedule.initial() {
    return const Schedule(
      id: "1",
      weekday: "Monday",
      intday: 1,
      available: false,
      shifts: [],
    );
  }
}
