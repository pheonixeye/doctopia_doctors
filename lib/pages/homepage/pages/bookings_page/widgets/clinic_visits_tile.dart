import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClinicVisitsTile extends StatefulWidget {
  const ClinicVisitsTile({
    super.key,
    required this.visit,
    required this.index,
  });
  final Visit visit;
  final int index;
  @override
  State<ClinicVisitsTile> createState() => _ClinicVisitsTileState();
}

class _ClinicVisitsTileState extends State<ClinicVisitsTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<PxClinicVisits, PxClinics, PxLocale>(
      builder: (context, v, c, l, _) {
        while (c.clinics == null) {
          return const CentralLoading();
        }
        while (c.clinics != null && c.clinics!.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          );
        }
        final clinic =
            c.clinics!.firstWhere((e) => e.id == widget.visit.clinic_id);
        final clinicName = l.isEnglish ? clinic.name_en : clinic.name_ar;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card.outlined(
            child: ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.visit.patient_name),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.visit.patient_phone),
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
                          DateFormat('dd / MM / yyyy', l.locale.languageCode)
                              .format(
                            widget.visit.visit_date,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          TimeOfDay(
                            hour: widget.visit.visit_shift.start_hour,
                            minute: widget.visit.visit_shift.start_minute,
                          ).format(context),
                        ),
                        const SizedBox(width: 20),
                        // if (widget.visit.type != null &&
                        //     widget.visit.type!.isNotEmpty)
                        //   FilterChip.elevated(
                        //     label: Text(widget.visit.type!),
                        //     onSelected: null,
                        //   ),
                      ],
                    ),
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
