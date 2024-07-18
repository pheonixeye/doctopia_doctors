import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_models/models/speciality.dart';
import 'package:provider/provider.dart';

class SpecialitySelector extends StatelessWidget {
  const SpecialitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Select Speciality'),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Consumer2<PxLocale, PxSpeciality>(
            builder: (context, l, s, c) {
              final isEnglish = l.locale.languageCode == 'en';
              return DropdownButtonFormField<Speciality>(
                validator: (value) {
                  if (value == null) {
                    return 'Kindly Select Speciality.';
                  }
                  return null;
                },
                alignment: Alignment.center,
                isExpanded: true,
                hint: const Text('Speciality...'),
                items: s.specialities.map((e) {
                  return DropdownMenuItem<Speciality>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(
                      isEnglish ? e.en : e.ar,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                // value: Speciality(
                //   en: context.read<PxDoctorMake>().doctor.speciality_en,
                //   ar: context.read<PxDoctorMake>().doctor.speciality_ar,
                // ),
                onChanged: (value) {
                  context.read<PxDoctor>().setDoctor(
                        speciality_en: value?.en,
                        speciality_ar: value?.ar,
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
