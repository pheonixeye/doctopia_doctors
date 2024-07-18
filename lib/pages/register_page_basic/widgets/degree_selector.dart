import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_models/models/degree.dart';
import 'package:provider/provider.dart';

class DegreeSelector extends StatelessWidget {
  const DegreeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Select Degree'),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Consumer<PxLocale>(
            builder: (context, l, c) {
              final isEnglish = l.locale.languageCode == 'en';
              return DropdownButtonFormField<Degree>(
                validator: (value) {
                  if (value == null) {
                    return 'Kindly Select Degree.';
                  }
                  return null;
                },
                alignment: Alignment.center,
                isExpanded: true,
                hint: const Text('Degree...'),
                items: Degree.list.map((e) {
                  return DropdownMenuItem<Degree>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(isEnglish ? e.en : e.ar),
                  );
                }).toList(),
                // value: Degree(
                //   en: context.read<PxDoctorMake>().doctor.degree_en,
                //   ar: context.read<PxDoctorMake>().doctor.degree_ar,
                // ),
                onChanged: (value) {
                  context.read<PxDoctor>().setDoctor(
                        degree_en: value?.en,
                        degree_ar: value?.ar,
                      );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
