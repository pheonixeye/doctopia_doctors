import 'package:doctopia_doctors/models/speciality.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecialitySelector extends StatefulWidget {
  const SpecialitySelector({super.key});

  @override
  State<SpecialitySelector> createState() => _SpecialitySelectorState();
}

class _SpecialitySelectorState extends State<SpecialitySelector> {
  Speciality? _speciality;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: const CircleAvatar(
      //   child: Text('^'),
      // ),
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
                value: _speciality,
                onChanged: (value) {
                  setState(() {
                    _speciality = value;
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
