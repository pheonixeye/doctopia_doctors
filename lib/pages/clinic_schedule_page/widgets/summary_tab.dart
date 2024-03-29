// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/functions/date_functions.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/pages/clinic_schedule_page/widgets/_px_dates.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
// import 'package:doctopia_doctors/providers/px_schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleSummaryTab extends StatefulWidget {
  const ScheduleSummaryTab({super.key});

  @override
  State<ScheduleSummaryTab> createState() => _ScheduleSummaryTabState();
}

class _ScheduleSummaryTabState extends State<ScheduleSummaryTab> {
  late final ScrollController _scrollController;
  // List<int> _onDates = [];

  // void _initScheduleProviders() async {
  //   final sch = context.read<PxSchedule>();
  //   final clinic = context.read<PxClinics>();

  //   final clinic_id = clinic.clinics[clinic.selectedIndex!].id;
  //   final scheduleList = await sch.fetchScheduleList(clinic_id);

  //   setState(() {
  //     _onDates = [...scheduleList.map((e) => e.$2.intday).toList()];
  //   });
  // }

  @override
  void initState() {
    // _initScheduleProviders();
    _scrollController = ScrollController();
    // context.read<PxDates>().initDates(_onDates);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          context.read<PxDates>().updateDates();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer3<PxLocale, PxClinics, PxDates>(
        builder: (context, l, c, d, child) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: d.dates.length,
            itemBuilder: (context, index) {
              final _d = d.dates[index];
              final isOff = c.clinics[c.selectedIndex!].clinic.off_dates
                  .contains(_d.toIso8601String());
              return ListTile(
                leading: const CircleAvatar(),
                title: Text(getWeekday(_d.weekday)!),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${_d.day} / ${_d.month} / ${_d.year}'),
                ),
                trailing: IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: isOff ? Colors.red : null,
                  ),
                  onPressed: () async {
                    await shellFunction(
                      context,
                      toExecute: () async {
                        late final Map<String, dynamic> _update;
                        List<String> clinicOffDates = [
                          ...c.clinics[c.selectedIndex!].clinic.off_dates
                        ];
                        if (isOff) {
                          clinicOffDates.remove(_d.toIso8601String());
                        } else {
                          clinicOffDates.add(_d.toIso8601String());
                        }

                        _update = {
                          'off_dates': clinicOffDates,
                        };
                        await c.updateClinic(
                            c.clinics[c.selectedIndex!].id, _update);
                      },
                    );
                  },
                  icon: isOff
                      ? const Icon(Icons.airplanemode_inactive_rounded)
                      : const Icon(Icons.airplanemode_active),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
