import 'package:doctopia_doctors/functions/date_functions.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic.dart';
import 'package:doctopia_doctors/providers/px_dates.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleSummaryTab extends StatefulWidget {
  const ScheduleSummaryTab({super.key, required this.clinic});
  final Clinic clinic;

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Consumer3<PxLocale, PxClinics, PxDates>(
        builder: (context, l, c, d, _) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: d.dates.length,
            itemBuilder: (context, index) {
              final _d = d.dates[index];
              final isOff =
                  widget.clinic.off_dates.contains(_d.toIso8601String());
              return Card.outlined(
                elevation: 2,
                child: ListTile(
                  leading: const CircleAvatar(),
                  title: Text(getWeekday(_d.weekday, l.isEnglish)),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat(
                        'dd / MM / yyyy',
                        l.locale.languageCode,
                      ).format(
                        DateTime(_d.year, _d.month, _d.day),
                      ),
                    ),
                  ),
                  trailing: IconButton.outlined(
                    style: IconButton.styleFrom(
                      backgroundColor: (isOff) ? Colors.amber : null,
                    ),
                    onPressed: () async {
                      final clinicOffDates = [...widget.clinic.off_dates];
                      if (isOff) {
                        clinicOffDates.remove(_d.toIso8601String());
                      } else {
                        clinicOffDates.add(_d.toIso8601String());
                      }
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await c.updateClinic(
                            widget.clinic.id,
                            {
                              'off_dates': clinicOffDates,
                            },
                          );
                        },
                      );
                    },
                    icon: (isOff)
                        ? const Icon(Icons.airplanemode_inactive_rounded)
                        : const Icon(Icons.airplanemode_active),
                  ),
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
