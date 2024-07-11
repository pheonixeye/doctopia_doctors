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

  @override
  void initState() {
    _scrollController = ScrollController();

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
        builder: (context, l, c, d, _) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: d.dates.length,
            itemBuilder: (context, index) {
              final _d = d.dates[index];
              final isOff = c.clinic?.off_dates.contains(_d.toIso8601String());
              return ListTile(
                leading: const CircleAvatar(),
                title: Text(getWeekday(_d.weekday)!),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${_d.day} / ${_d.month} / ${_d.year}'),
                ),
                trailing: IconButton.outlined(
                  style: IconButton.styleFrom(
                    backgroundColor:
                        (isOff != null && isOff) ? Colors.red : null,
                  ),
                  onPressed: () async {
                    await shellFunction(
                      context,
                      toExecute: () async {
                        late final Map<String, dynamic> _update;
                        List<String> clinicOffDates = [...c.clinic!.off_dates];
                        if (isOff != null && isOff) {
                          clinicOffDates.remove(_d.toIso8601String());
                        } else {
                          clinicOffDates.add(_d.toIso8601String());
                        }

                        _update = {
                          'off_dates': clinicOffDates,
                        };
                        await c
                            .updateClinic(c.clinic!.id, _update)
                            .whenComplete(() {
                          c.selectClinic(c.clinic);
                        });
                      },
                    );
                  },
                  icon: (isOff != null && isOff)
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
