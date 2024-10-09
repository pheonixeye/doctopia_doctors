// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/extensions/attendance_translation_helper_ext.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/clinic_schedule_page/widgets/patient_number_picker_dialog.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_models/models/clinic_shift.dart';
import 'package:proklinik_models/models/schedule.dart';
import 'package:provider/provider.dart';

class ScheduleManagementTab extends StatefulWidget {
  const ScheduleManagementTab({super.key});

  @override
  State<ScheduleManagementTab> createState() => _ScheduleManagementTabState();
}

class _ScheduleManagementTabState extends State<ScheduleManagementTab>
    with AfterLayoutMixin {
  List<Schedule> _state = [];

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final clinic = context.read<PxClinics>().clinic;
    setState(() {
      _state = clinic!.schedule;
    });
  }

  TextStyle get _clickable => TextStyle(
        color: Theme.of(context).appBarTheme.backgroundColor,
        fontSize: 16,
        decoration: TextDecoration.underline,
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // update clinic attendance type
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(context.loc.selectAtt),
              subtitle: Consumer2<PxLocale, PxClinics>(
                builder: (context, l, c, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...[true, false].map((e) {
                        return RadioMenuButton<bool>(
                          value: e,
                          groupValue: c.clinic?.attendance,
                          onChanged: (value) async {
                            await shellFunction(
                              context,
                              toExecute: () async {
                                await c.updateClinic(
                                  c.clinic!.id,
                                  {
                                    'attendance': value,
                                  },
                                );
                              },
                            );
                          },
                          child: Text(_rep[e]!.ifAttendanceTransalate(context)),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        const Divider(),
        // create schedule shifts
        Consumer<PxClinics>(
          builder: (context, c, _) {
            final clinic = c.clinic;
            while (clinic == null) {
              return const SizedBox();
            }
            Future<void> _updateSchedule() async {
              await shellFunction(
                context,
                toExecute: () async {
                  await c.updateClinic(
                    c.clinic!.id,
                    {"schedule": _state.map((e) => e.toJson()).toList()},
                  );
                },
              );
            }

            return ListTile(
              title: const Text('Clinic Shifts'),
              subtitle: Column(
                children: [
                  for (int i = 0; i < _state.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card.outlined(
                        child: ListTile(
                          title: Card.outlined(
                            elevation: 0,
                            color: Theme.of(context)
                                .appBarTheme
                                .backgroundColor
                                ?.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Text(_state[i].weekday),
                                  const Spacer(),
                                  Switch(
                                    value: _state[i].available,
                                    onChanged: (value) async {
                                      setState(() {
                                        _state[i] = _state[i].copyWith(
                                          available: value,
                                        );
                                      });
                                      await _updateSchedule();
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                          subtitle: ListTile(
                            title: Row(
                              children: [
                                const SizedBox(width: 10),
                                const Text("Clinic Shifts"),
                                const Spacer(),
                                const SizedBox(width: 10),
                                FloatingActionButton.small(
                                  tooltip: 'Add Clinic Shift',
                                  heroTag: 'add-clinic-shift$i',
                                  onPressed: () async {
                                    setState(() {
                                      _state[i] = _state[i].copyWith(
                                        shifts: [
                                          ..._state[i].shifts,
                                          ClinicShift.initial(),
                                        ],
                                      );
                                    });
                                    await _updateSchedule();
                                  },
                                  child: const Icon(Icons.add),
                                )
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                for (int j = 0;
                                    j < _state[i].shifts.length;
                                    j++,)
                                  Builder(
                                    builder: (context) {
                                      final shift = _state[i].shifts[j];
                                      return ListTile(
                                        title: Text.rich(
                                          TextSpan(
                                            text: '(${j + 1})\n',
                                            children: [
                                              const TextSpan(text: 'From : '),
                                              TextSpan(
                                                text: TimeOfDay(
                                                        hour: shift.startH
                                                            .toInt(),
                                                        minute: shift.startM
                                                            .toInt())
                                                    .format(context),
                                                style: _clickable,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        final TimeOfDay? _time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (_time == null) {
                                                          return;
                                                        }
                                                        final _updatedShift =
                                                            shift.copyWith(
                                                          startH: _time.hour,
                                                          startM: _time.minute,
                                                        );
                                                        _state[i].shifts[j] =
                                                            _updatedShift;

                                                        setState(() {
                                                          _state[i] = _state[i]
                                                              .copyWith(
                                                            shifts: [
                                                              ..._state[i]
                                                                  .shifts
                                                            ],
                                                          );
                                                        });
                                                        await _updateSchedule();
                                                      },
                                              ),
                                              const TextSpan(text: '\n'),
                                              const TextSpan(text: 'To : '),
                                              TextSpan(
                                                text: TimeOfDay(
                                                        hour:
                                                            shift.endH.toInt(),
                                                        minute:
                                                            shift.endM.toInt())
                                                    .format(context),
                                                style: _clickable,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        final TimeOfDay? _time =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (_time == null) {
                                                          return;
                                                        }
                                                        final _updatedShift =
                                                            shift.copyWith(
                                                          endH: _time.hour,
                                                          endM: _time.minute,
                                                        );
                                                        _state[i].shifts[j] =
                                                            _updatedShift;

                                                        setState(() {
                                                          _state[i] = _state[i]
                                                              .copyWith(
                                                            shifts: [
                                                              ..._state[i]
                                                                  .shifts
                                                            ],
                                                          );
                                                        });
                                                        await _updateSchedule();
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text: 'Visits Per Shift : ',
                                                children: [
                                                  TextSpan(
                                                    text: '${shift.patients}',
                                                    style: _clickable,
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () async {
                                                            final numberOfPatients =
                                                                await showDialog<
                                                                    int>(
                                                              context: context,
                                                              builder: (context) =>
                                                                  const PatientNumberPickerDialog(),
                                                            );
                                                            if (numberOfPatients ==
                                                                null) {
                                                              return;
                                                            }
                                                            final _updatedShift =
                                                                shift.copyWith(
                                                              patients:
                                                                  numberOfPatients,
                                                            );
                                                            _state[i]
                                                                    .shifts[j] =
                                                                _updatedShift;
                                                            await _updateSchedule();
                                                          },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Expanded(
                                              child: Divider(),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        trailing: FloatingActionButton.small(
                                          heroTag: shift,
                                          onPressed: () async {
                                            setState(() {
                                              _state[i] = _state[i].copyWith(
                                                shifts: [
                                                  ..._state[i].shifts,
                                                ]..remove(shift),
                                              );
                                            });
                                            await _updateSchedule();
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

const Map<bool, String> _rep = {
  true: "By Time",
  false: "FiFo",
};
