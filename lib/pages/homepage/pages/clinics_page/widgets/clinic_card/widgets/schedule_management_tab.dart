import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/functions/date_functions.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/attendance_type.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_shift.dart';
import 'package:doctopia_doctors/models/clinic_response_model/schedule.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/dialogs/patient_number_picker_dialog.dart';
import 'package:doctopia_doctors/providers/px_app_constants.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleManagementTab extends StatefulWidget {
  const ScheduleManagementTab({super.key, required this.clinic});
  final Clinic clinic;

  @override
  State<ScheduleManagementTab> createState() => _ScheduleManagementTabState();
}

class _ScheduleManagementTabState extends State<ScheduleManagementTab> {
  List<Schedule>? _state;

  @override
  void didChangeDependencies() {
    _state = widget.clinic.schedule;
    super.didChangeDependencies();
  }

  TextStyle get _clickable => TextStyle(
        color: Theme.of(context).appBarTheme.backgroundColor,
        fontSize: 16,
        decoration: TextDecoration.underline,
      );

  Future<void> _updateSchedule(PxClinics c) async {
    if (_state == null) {
      return;
    }
    await shellFunction(
      context,
      toExecute: () async {
        await c.updateClinic(
          widget.clinic.id,
          {
            'schedule': _state?.map((e) => e.toJson()).toList(),
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<PxLocale, PxClinics, PxAppConstants>(
      builder: (context, l, c, a, _) {
        while (a.model == null) {
          return const CentralLoading();
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Card.outlined(
                elevation: 0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(context.loc.selectAtt),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...a.model!.attendance_types.map((att) {
                        return RadioListTile<AttendanceType>(
                          title: Text(l.isEnglish ? att.name_en : att.name_ar),
                          value: att,
                          groupValue: widget.clinic.attendance_type,
                          onChanged: (value) async {
                            await shellFunction(
                              context,
                              toExecute: () async {
                                await c.updateClinic(
                                  widget.clinic.id,
                                  {
                                    'attendance_type_id': value?.id,
                                  },
                                );
                              },
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ...widget.clinic.schedule.map((sch) {
                    return Card.outlined(
                      elevation: 0,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Row(
                          children: [
                            if (sch.available) ...[
                              const SizedBox(width: 5),
                              IconButton.outlined(
                                onPressed: () async {
                                  var _toUpdate = _state!.firstWhere(
                                      (e) => e.weekday == sch.weekday);
                                  final _index = _state!.indexOf(_toUpdate);
                                  _toUpdate = _toUpdate.copyWith(
                                    shifts: [
                                      ..._toUpdate.shifts,
                                      ClinicShift.initial(),
                                    ],
                                  );
                                  _state![_index] = _toUpdate;
                                  await _updateSchedule(c);
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                l.isEnglish
                                    ? sch.weekday
                                    : sch.weekday.ifWeekdayTranslate(context),
                              ),
                            ),
                            Switch.adaptive(
                              value: sch.available,
                              onChanged: (value) async {
                                var _toUpdate = _state!.firstWhere(
                                    (e) => e.weekday == sch.weekday);
                                final _index = _state!.indexOf(_toUpdate);
                                _toUpdate = _toUpdate.copyWith(
                                  available: value,
                                );
                                _state![_index] = _toUpdate;

                                await _updateSchedule(c);
                              },
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                        subtitle: Card.outlined(
                          elevation: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...sch.shifts.map((shift) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    tileColor: Theme.of(context)
                                        .primaryColor
                                        .withValues(alpha: 0.1),
                                    subtitle: Row(
                                      children: [
                                        Expanded(child: Divider()),
                                        IconButton.outlined(
                                          onPressed: () async {
                                            //todo: delete shift

                                            final _scheduleIndex =
                                                _state!.indexOf(sch);
                                            final _shiftIndex = _state!
                                                .firstWhere((sched) =>
                                                    sched.weekday ==
                                                    sch.weekday)
                                                .shifts
                                                .indexOf(shift);
                                            _state![_scheduleIndex]
                                                .shifts
                                                .removeAt(_shiftIndex);
                                            await _updateSchedule(c);
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                    title: Builder(
                                      builder: (context) {
                                        ///[x] => schedule
                                        ///[y] => shift
                                        final _toUpdateSchedule = _state!
                                            .firstWhere((x) =>
                                                x.weekday == sch.weekday);
                                        final _scheduleIndex =
                                            _state!.indexOf(_toUpdateSchedule);
                                        final _toUpdateShift =
                                            _toUpdateSchedule.shifts.firstWhere(
                                                (y) => y.id == shift.id);
                                        final _shiftIndex = _toUpdateSchedule
                                            .shifts
                                            .indexOf(_toUpdateShift);
                                        return Text.rich(
                                          TextSpan(
                                            text:
                                                '(${sch.shifts.indexOf(shift) + 1}) '
                                                    .toArabicNumber(context),
                                            children: [
                                              TextSpan(text: context.loc.from),
                                              TextSpan(text: ' '),
                                              TextSpan(
                                                text: DateFormat.jm(
                                                        l.locale.languageCode)
                                                    .format(
                                                  DateTime.now().copyWith(
                                                    hour: shift.startH.toInt(),
                                                    minute:
                                                        shift.startM.toInt(),
                                                  ),
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        final _newStart =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (_newStart == null) {
                                                          return;
                                                        }
                                                        _state![_scheduleIndex]
                                                                .shifts[
                                                            _shiftIndex] = _state![
                                                                _scheduleIndex]
                                                            .shifts[_shiftIndex]
                                                            .copyWith(
                                                              startH: _newStart
                                                                  .hour,
                                                              startM: _newStart
                                                                  .minute,
                                                            );
                                                        await _updateSchedule(
                                                            c);
                                                      },
                                                style: _clickable,
                                              ),
                                              TextSpan(text: ' '),
                                              TextSpan(text: context.loc.to),
                                              TextSpan(text: ' '),
                                              TextSpan(
                                                text: DateFormat.jm(
                                                        l.locale.languageCode)
                                                    .format(
                                                  DateTime.now().copyWith(
                                                    hour: shift.endH.toInt(),
                                                    minute: shift.endM.toInt(),
                                                  ),
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        final _newEnd =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (_newEnd == null) {
                                                          return;
                                                        }
                                                        _state![_scheduleIndex]
                                                                .shifts[
                                                            _shiftIndex] = _state![
                                                                _scheduleIndex]
                                                            .shifts[_shiftIndex]
                                                            .copyWith(
                                                              endH:
                                                                  _newEnd.hour,
                                                              endM: _newEnd
                                                                  .minute,
                                                            );
                                                        await _updateSchedule(
                                                            c);
                                                      },
                                                style: _clickable,
                                              ),
                                              TextSpan(text: '\n'),
                                              TextSpan(
                                                  text: context
                                                      .loc.numberOfPatients),
                                              TextSpan(text: ' '),
                                              TextSpan(
                                                text: '(${shift.patients})'
                                                    .toArabicNumber(context),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        final _newPatientsNumber =
                                                            await showDialog<
                                                                    int?>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return const PatientNumberPickerDialog();
                                                                });
                                                        if (_newPatientsNumber ==
                                                            null) {
                                                          return;
                                                        }
                                                        _state![_scheduleIndex]
                                                                .shifts[
                                                            _shiftIndex] = _state![
                                                                _scheduleIndex]
                                                            .shifts[_shiftIndex]
                                                            .copyWith(
                                                              patients:
                                                                  _newPatientsNumber,
                                                            );
                                                        await _updateSchedule(
                                                            c);
                                                      },
                                                style: _clickable,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
