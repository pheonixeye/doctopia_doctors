import 'package:doctopia_doctors/models/documents/documents.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPublishMenuButton extends StatefulWidget {
  const AccountPublishMenuButton({super.key});

  @override
  State<AccountPublishMenuButton> createState() =>
      _AccountPublishMenuButtonState();
}

class _AccountPublishMenuButtonState extends State<AccountPublishMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer4<PxLocale, PxDoctor, PxDocuments, PxClinics>(
      builder: (context, l, doctor, documents, clinics, child) {
        final isEnglish = l.locale.languageCode == 'en';
        return PopupMenuButton<bool>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).colorScheme.secondaryContainer,
          shadowColor: Colors.grey.shade400,
          offset: const Offset(-20, 20),
          elevation: 10,
          itemBuilder: (context) {
            return <PopupMenuEntry<bool>>[
              //TODO: show info about missing attributes till sending publishing request.
              ...documents.doctorDocuments!.toJson().entries.map((e) {
                return PopupMenuItem<bool>(
                  enabled: false,
                  value: (e.value == null || e.value.toString().trim().isEmpty),
                  child: ListTile(
                    leading: CircleAvatar(
                      child:
                          (e.value == null || e.value.toString().trim().isEmpty)
                              ? const Icon(Icons.close)
                              : const Icon(Icons.check),
                    ),
                    title: Text(
                      DoctorDocuments.keyToWidget(e.key, isEnglish),
                      style: (doctor.doctor.degree_en != 'Consultant' &&
                              e.key == 'consultant_cert')
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
              PopupMenuItem<bool>(
                enabled: false,
                value: (clinics.clinics.isEmpty),
                child: ListTile(
                  leading: CircleAvatar(
                    child: (clinics.clinics.isEmpty)
                        ? const Icon(Icons.close)
                        : const Icon(Icons.check),
                  ),
                  title: const Text('Add One Clinic'),
                ),
              ),
              PopupMenuItem<bool>(
                enabled: false,
                value: (clinics.clinics.any((x) => x.clinic.published)),
                child: ListTile(
                  leading: CircleAvatar(
                    child:
                        (clinics.clinics.any((x) => x.clinic.published == true))
                            ? const Icon(Icons.check)
                            : const Icon(Icons.close),
                  ),
                  title: const Text('Publish One Clinic'),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      //TODO: if info is complete, send publishing request
                    },
                    icon: const Icon(Icons.public),
                    label: const Text('Request Publish'),
                  ),
                ),
              ),
            ];
          },
          tooltip: 'Account Not Published...',
          child: const Icon(
            Icons.info,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
