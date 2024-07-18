// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/functions/date_functions.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // update clinic attendance type
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Attendance'),
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
                          child: Text(_rep[e]!),
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
            return ListTile(
              title: const Text('Clinic Shifts'),
              subtitle: Column(
                children: [
                  for (int i = 0; i < _state.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card.outlined(
                        child: ListTile(
                          leading: IconButton.outlined(
                            onPressed: () {},
                            icon: Icon(
                              _state[i].available ? Icons.check : Icons.close,
                            ),
                          ),
                          title: Text(_state[i].weekday),
                          trailing: Switch(
                            value: _state[i].available,
                            onChanged: (value) async {
                              setState(() {
                                _state[i] = _state[i].copyWith(
                                  available: value,
                                );
                              });
                              await shellFunction(
                                context,
                                toExecute: () async {
                                  c.updateClinic(
                                    clinic.id,
                                    {
                                      "schedule":
                                          _state.map((e) => e.toJson()).toList()
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          subtitle: ListTile(
                            title: Text.rich(
                              TextSpan(
                                text: "",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "From ${fT(_state[i].startHour, _state[i].startMin)}",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final TimeOfDay? _time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (_time != null && context.mounted) {
                                          await shellFunction(context,
                                              toExecute: () async {
                                            setState(() {
                                              _state[i] = _state[i].copyWith(
                                                startHour: _time.hour,
                                                startMin: _time.minute,
                                              );
                                            });
                                            await c.updateClinic(clinic.id, {
                                              "schedule": _state
                                                  .map((e) => e.toJson())
                                                  .toList(),
                                            });
                                          });
                                        }
                                      },
                                  ),
                                  const TextSpan(text: "\n\n"),
                                  TextSpan(
                                    text:
                                        "To ${fT(_state[i].endHour, _state[i].endMin)}",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final TimeOfDay? _time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (_time != null && context.mounted) {
                                          await shellFunction(context,
                                              toExecute: () async {
                                            setState(() {
                                              _state[i] = _state[i].copyWith(
                                                endHour: _time.hour,
                                                endMin: _time.minute,
                                              );
                                            });
                                            await c.updateClinic(clinic.id, {
                                              "schedule": _state
                                                  .map((e) => e.toJson())
                                                  .toList(),
                                            });
                                          });
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
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
