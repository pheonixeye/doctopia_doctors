// ignore_for_file: prefer_final_fields

import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/clinic_card/clinic_card.dart';
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
          title: Text(context.loc.clinics),
          subtitle: const Divider(),
          trailing: FloatingActionButton.small(
            heroTag: 'create-clinic',
            onPressed: () {
              GoRouter.of(context).goNamed(
                AppRouter.createclinic,
                pathParameters: {
                  "id": context.read<PxClinics>().doc_id,
                },
              );
            },
            tooltip: context.loc.createClinic,
            child: const Icon(Icons.add),
          ),
        ),
        Consumer2<PxLocale, PxClinics>(
          builder: (context, l, c, _) {
            while (c.clinics == null) {
              return Padding(
                padding: const EdgeInsets.only(top: 280.0),
                child: const CentralLoading(),
              );
            }
            while (c.clinics != null && c.clinics!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 280.0),
                child: Center(
                  child: Card.outlined(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.loc.noClinicsYet),
                    ),
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: c.clinics?.length,
                itemBuilder: (context, index) {
                  return ClinicCard(clinic: c.clinics![index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
