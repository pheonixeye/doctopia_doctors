import 'package:doctopia_doctors/components/info_dialog.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/documents/documents.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_publish_request.dart';
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
    return Consumer5<PxLocale, PxDoctor, PxDocuments, PxClinics,
        PxPublishRequest>(
      builder: (context, l, doctor, documents, clinics, pub, child) {
        if (doctor.doctor.published) {
          return const SizedBox();
        } else {
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
                //show info about missing attributes till sending publishing request.
                ...documents.doctorDocuments!.toJson().entries.map((e) {
                  return PopupMenuItem<bool>(
                    enabled: false,
                    value:
                        (e.value == null || e.value.toString().trim().isEmpty),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: (e.value == null ||
                                e.value.toString().trim().isEmpty)
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
                      child: (clinics.clinics
                              .any((x) => x.clinic.published == true))
                          ? const Icon(Icons.check)
                          : const Icon(Icons.close),
                    ),
                    title: const Text('Publish One Clinic'),
                  ),
                ),
                const PopupMenuDivider(),
                if (pub.publishRequest == null)
                  PopupMenuItem(
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          //validate info is complete
                          if (documents.doctorDocuments!.toJson().entries.any(
                              (element) =>
                                  element.value == null ||
                                  element.value.toString().isEmpty)) {
                            await showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return const InformationDialog(
                                    title: "Missing Doctor Documents.",
                                    body:
                                        "Kindly Supply The Requested Documents Before Requesting Profile Publishing.",
                                  );
                                });
                          } else if (clinics.clinics.isEmpty) {
                            await showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return const InformationDialog(
                                    title: "No Clinic Found.",
                                    body:
                                        "Kindly Add and Publish Atleast One Clinic Before Requesting Profile Publishing.",
                                  );
                                });
                          } else if (clinics.clinics
                              .any((x) => x.clinic.published == false)) {
                            await showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return const InformationDialog(
                                    title: "Clinic Found with No Schedule.",
                                    body:
                                        "Kindly Add a Schedule for your Clinics Before Requesting Profile Publishing.",
                                  );
                                });
                          } else {
                            //TODO: send account publish request.
                            await shellFunction(
                              context,
                              toExecute: () async {
                                await pub.createPublishRequest(
                                  synd_id: doctor.doctor.synd_id,
                                  name_en: doctor.doctor.name_en,
                                  name_ar: doctor.doctor.name_ar,
                                  published: false,
                                );
                              },
                            );
                          }
                        },
                        icon: const Icon(Icons.public),
                        label: const Text('Request Publish'),
                      ),
                    ),
                  ),
                if (pub.publishRequest != null &&
                    pub.publishRequest!.published == false)
                  const PopupMenuItem(
                    child: Center(
                      child: Text(
                        'Your Account is Under Review.',
                        textAlign: TextAlign.center,
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
        }
      },
    );
  }
}
