import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:flutter/material.dart';

class PatientNumberPickerDialog extends StatelessWidget {
  const PatientNumberPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Row(
        children: [
          Expanded(child: Text(context.loc.numberOfPatients)),
          IconButton.outlined(
            onPressed: () {
              Navigator.pop(context, null);
            },
            icon: const Icon(Icons.close),
          ),
          const SizedBox(width: 5),
        ],
      ),
      content: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...[5, 10, 15, 20, 25, 30].map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, e);
                },
                child: Text(
                  e.toString().toArabicNumber(context),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
