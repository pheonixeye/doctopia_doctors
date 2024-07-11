import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/clinic_visit/clinic_visit.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicVisitsTile extends StatefulWidget {
  const ClinicVisitsTile({
    super.key,
    required this.visit,
    required this.index,
  });
  final ClinicVisit visit;
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
    return Consumer2<PxClinicVisits, PxClinics>(
      builder: (context, v, c, _) {
        while (c.clinics.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          );
        }
        final clinicName =
            c.clinics.firstWhere((e) => e.id == widget.visit.clinic_id).name_en;
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
                        Text("${_d.day}-${_d.month}-${_d.year}"),
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
                      await shellFunction(context, toExecute: () async {
                        await v.updateClinicVisit(
                          widget.visit.id,
                          !widget.visit.attended,
                        );
                      });
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
