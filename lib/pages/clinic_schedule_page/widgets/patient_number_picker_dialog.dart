import 'package:flutter/material.dart';

class PatientNumberPickerDialog extends StatelessWidget {
  const PatientNumberPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Text("Patients / Shift"),
          const Spacer(),
          IconButton.outlined(
            onPressed: () {
              Navigator.pop(context, null);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Wrap(
        children: [
          ...List.generate(20, (index) => index + 1).map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, e);
                },
                child: Text(
                  e.toString(),
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
