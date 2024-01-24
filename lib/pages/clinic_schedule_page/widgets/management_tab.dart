// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/pages/clinic_schedule_page/widgets/add_clinic_shift_dialog.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleManagementTab extends StatefulWidget {
  const ScheduleManagementTab({super.key});

  @override
  State<ScheduleManagementTab> createState() => _ScheduleManagementTabState();
}

class _ScheduleManagementTabState extends State<ScheduleManagementTab>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final _clinicsPx = context.read<PxClinics>();
    await context
        .read<PxSchedule>()
        .fetchScheduleList(_clinicsPx.clinics[_clinicsPx.selectedIndex!].id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          groupValue:
                              c.clinics[c.selectedIndex!].clinic.attendance,
                          onChanged: (value) async {
                            await shellFunction(
                              context,
                              toExecute: () async {
                                await c.updateClinic(
                                  c.clinics[c.selectedIndex!].id,
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
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    const Text('Clinic Shifts'),
                    const Spacer(),
                    Consumer<PxClinics>(
                      builder: (context, c, _) {
                        return FloatingActionButton.small(
                          heroTag: 'add-clinic-shift-btn',
                          onPressed: () async {
                            final result = await showAdaptiveDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return const AddClinicShiftDialog();
                                });
                            if (result != null && result && mounted) {
                              await shellFunction(context, toExecute: () async {
                                await context.read<PxSchedule>().addSchedule(
                                    c.clinics[c.selectedIndex!].id);
                              });
                            }
                          },
                          child: const Icon(Icons.add),
                        );
                      },
                    ),
                  ],
                ),
                subtitle: Consumer2<PxSchedule, PxClinics>(
                  //TODO: find a way to better scroll the schedule items
                  //TODO: add update schedule UI & algorithm
                  //TODO: format date and time properly
                  builder: (context, s, c, _) {
                    final clinic_id = c.clinics[c.selectedIndex!].id;
                    while (s.scheduleList.isEmpty) {
                      return const Center(
                        child: Text('No Clinic Shifts Yet.'),
                      );
                    }
                    return ListView.separated(
                      itemCount: s.scheduleList.length,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        final _sch = s.scheduleList[index].$2;
                        return ListTile(
                          title: Text(_sch.weekday),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('From: ${_sch.start} - To: ${_sch.end}'),
                              Text('Number of Patients: ${_sch.slots}'),
                            ],
                          ),
                          trailing: FloatingActionButton.small(
                            heroTag: s.scheduleList[index].$1,
                            onPressed: () async {
                              await shellFunction(
                                context,
                                toExecute: () async {
                                  await s.deleteSchedule(
                                      clinic_id, s.scheduleList[index].$1);
                                },
                              );
                            },
                            child: const Icon(Icons.delete_forever),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const Map<bool, String> _rep = {
  true: "By Time",
  false: "FiFo",
};
