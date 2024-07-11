// ignore_for_file: prefer_final_fields

import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/clinic_card.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: find why the state is not updating on creating a new clinic
    return ListView(
      cacheExtent: 3000,
      children: [
        const ListTile(
          leading: CircleAvatar(),
          title: Text('My Clinics'),
        ),
        Consumer2<PxLocale, PxClinics>(
          builder: (context, l, c, _) {
            while (c.clinics.isEmpty) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(250),
                  Center(
                    child: Text('No Clinics Created Yet.'),
                  ),
                ],
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: c.clinics.length,
              itemBuilder: (context, index) {
                return ClinicCard(clinic: c.clinics[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
