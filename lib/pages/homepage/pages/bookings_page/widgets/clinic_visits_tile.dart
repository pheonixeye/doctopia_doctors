import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proklinik_models/proklinik_models.dart';
import 'package:provider/provider.dart';

class ClinicVisitsTile extends StatefulWidget {
  const ClinicVisitsTile({
    super.key,
    required this.visit,
    required this.index,
  });
  final BookingData visit;
  final int index;
  @override
  State<ClinicVisitsTile> createState() => _ClinicVisitsTileState();
}

class _ClinicVisitsTileState extends State<ClinicVisitsTile> {
  late final DateTime _d;
  @override
  void initState() {
    _d = DateTime.parse(widget.visit.date_time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<PxClinicVisits, PxClinics, PxLocale>(
      builder: (context, v, c, l, _) {
        while (c.clinics.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          );
        }
        final clinic =
            c.clinics.firstWhere((e) => e.id == widget.visit.clinic_id);
        final clinicName = l.isEnglish ? clinic.name_en : clinic.name_ar;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card.outlined(
            child: ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.visit.user_name),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.visit.user_phone),
              ),
              leading: CircleAvatar(
                child: Text("${widget.index + 1}"),
              ),
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(clinicName),
                  ), //fetch clinic from id
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy', l.locale.languageCode)
                              .format(
                            DateTime(_d.year, _d.month, _d.day),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          TimeOfDay(
                            hour: widget.visit.startH.toInt(),
                            minute: widget.visit.startM.toInt(),
                          ).format(context),
                        ),
                        const SizedBox(width: 20),
                        if (widget.visit.type != null &&
                            widget.visit.type!.isNotEmpty)
                          FilterChip.elevated(
                            label: Text(widget.visit.type!),
                            onSelected: null,
                          ),
                      ],
                    ),
                  ),
                  trailing: IconButton.outlined(
                    style: IconButton.styleFrom(
                      backgroundColor:
                          widget.visit.attended ? null : Colors.red,
                    ),
                    onPressed: () async {
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await v.updateClinicVisit(
                            widget.visit.id,
                            !widget.visit.attended,
                          );
                        },
                      );
                    },
                    icon: widget.visit.attended
                        ? const Icon(Icons.airplanemode_inactive)
                        : const Icon(Icons.airplanemode_active),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
