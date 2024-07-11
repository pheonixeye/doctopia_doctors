import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicVisitsTile extends StatefulWidget {
  const ClinicVisitsTile({super.key, required this.clinicData});
  final ({Clinic clinic, String id}) clinicData;

  @override
  State<ClinicVisitsTile> createState() => _ClinicVisitsTileState();
}

class _ClinicVisitsTileState extends State<ClinicVisitsTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PxClinicVisits>(
      builder: (context, v, c) {
        final _visits =
            v.data.where((x) => x.clinic_id == widget.clinicData.id);
        return ExpansionTile(
          leading: const CircleAvatar(),
          initiallyExpanded: true,
          title: Text(widget.clinicData.clinic.name_en),
          children: [
            if (v.data.isEmpty)
              const Text('No Visits On Selected Date.')
            else
              ..._visits.map((e) {
                //TODO: SHOW VISIT DETAILS
                return Card(
                  child: Text(e.date),
                );
              }).toList(),
          ],
        );
      },
    );
  }
}
