// ignore_for_file: prefer_final_fields

import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/clinic_card.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  @override
  Widget build(BuildContext context) {
    //fixed: find why the state is not updating on creating a new clinic
    //new instance of PxClinics did not know about the clinics fetched by the other
    //instance - static fixed the issue

    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(),
          title: const Text('My Clinics'),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              heroTag: 'create-clinic',
              onPressed: () {
                GoRouter.of(context).goNamed(
                  AppRouter.createclinic,
                  pathParameters: {
                    "id": context.read<PxClinics>().id,
                  },
                );
              },
              label: const Text('Create Clinic'),
              icon: const Icon(Icons.add),
            ),
          ),
        ),
        Consumer2<PxLocale, PxClinics>(
          builder: (context, l, c, _) {
            while (c.clinics.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 200.0),
                child: Center(
                  child: Card.outlined(
                    elevation: 6,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No Clinics Created Yet.'),
                    ),
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: c.clinics.length,
                itemBuilder: (context, index) {
                  return ClinicCard(clinic: c.clinics[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
