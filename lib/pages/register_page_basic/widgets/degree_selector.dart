import 'package:doctopia_doctors/models/degree/degree.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DegreeSelector extends StatefulWidget {
  const DegreeSelector({super.key});

  @override
  State<DegreeSelector> createState() => _DegreeSelectorState();
}

class _DegreeSelectorState extends State<DegreeSelector> {
  Degree? _degree;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: const CircleAvatar(
      //   child: Text('^'),
      // ),
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
                value: _degree,
                onChanged: (value) {
                  setState(() {
                    _degree = value;
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
