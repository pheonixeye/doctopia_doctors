// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/api/schedule_api/schedule_api.dart';
import 'package:doctopia_doctors/models/schedule/schedule.dart';
import 'package:flutter/material.dart';

class PxSchedule extends ChangeNotifier {
  final HxSchedule scheduleService;

  PxSchedule({required this.scheduleService});

  List<(String, Schedule)> _scheduleList = [];
  List<(String, Schedule)> get scheduleList => _scheduleList;

  Schedule _schedule = Schedule.initial();
  Schedule get schedule => _schedule;

  void setSchedule({
    String? weekday,
    int? intday,
    int? startHour,
    int? startMin,
    int? endHour,
    int? endMin,
    int? slots,
  }) {
    _schedule = _schedule.copyWith(
      weekday: weekday ?? _schedule.weekday,
      intday: intday ?? _schedule.intday,
      startHour: startHour ?? _schedule.startHour,
      startMin: startMin ?? _schedule.startMin,
      endHour: endHour ?? _schedule.endHour,
      endMin: endMin ?? _schedule.endMin,
    );
    notifyListeners();
  }

  Future<List<(String, Schedule)>> fetchScheduleList(String clinic_id) async {
    try {
      final response = await scheduleService.fetchClinicScheduleList(clinic_id);
      _scheduleList = response;
      notifyListeners();
      return _scheduleList;
    } catch (e) {
      rethrow;
    }
  }

  Future<Schedule> addSchedule(String clinic_id) async {
    try {
      final response = await scheduleService.addSchedule(
        clinic_id,
        schedule,
      );
      _schedule = response.$2;
      notifyListeners();
      await fetchScheduleList(clinic_id);
      return _schedule;
    } catch (e) {
      rethrow;
    }
  }

  Future<Schedule> updateSchedule(String clinic_id, String id) async {
    try {
      final response =
          await scheduleService.updateSchedule(clinic_id, id, schedule);
      _schedule = response.$2;
      notifyListeners();
      await fetchScheduleList(clinic_id);

      return _schedule;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSchedule(String clinic_id, String id) async {
    try {
      await scheduleService.deleteSchedule(clinic_id, id);
      await fetchScheduleList(clinic_id);
    } catch (e) {
      rethrow;
    }
  }
}
