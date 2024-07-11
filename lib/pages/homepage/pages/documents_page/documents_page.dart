import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/documents/documents.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:file_picker/file_picker.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context
        .read<PxDocuments>()
        .initDocuments(context.read<PxDoctor>().doctor!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxDocuments, PxLocale>(
      builder: (context, d, l, c) {
        final isEnglish = l.locale.languageCode == 'en';
        return ListView(
          children: [
            const ListTile(
              leading: CircleAvatar(),
              title: Text('My Documents'),
            ),
            if (d.doctorDocuments == null)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              ...d.doctorDocuments!.toJson().entries.map((e) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        child: (e.value == null ||
                                e.value.toString().trim().isEmpty)
                            ? const Icon(Icons.close)
                            : const Icon(Icons.check),
                      ),
                      initiallyExpanded: false,
                      title:
                          Text(DoctorDocuments.keyToWidget(e.key, isEnglish)),
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            FutureBuilder(
                                future: (e.value == null ||
                                        e.value.toString().trim().isEmpty)
                                    ? null
                                    : d.documentsService.fetchImage(e.value),
                                builder: (context, snapshot) {
                                  while (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  while (snapshot.data == null ||
                                      snapshot.hasError) {
                                    return const Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 75,
                                    );
                                  }
                                  return Image.memory(
                                    snapshot.data!,
                                    width: 250,
                                    height: 250,
                                  );
                                }),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.upload),
                              label: const Text('Upload Image'),
                              onPressed: () async {
                                // late String? imgPath;
                                // final FilePickerResult? _pickedFiles =
                                //     await FilePicker.platform.pickFiles(
                                //   type: FileType.image,
                                // );
                                // if (_pickedFiles != null) {
                                //   imgPath = _pickedFiles.files.first.path;
                                // }
                                // if (imgPath != null && mounted) {
                                //   final fileName =
                                //       '''${context.read<PxDoctor>().doctor!.name_en.replaceAll(' ', '_')}-${e.key}-${DateTime.now().toIso8601String()}.${_pickedFiles!.files.first.extension}'''
                                //           .replaceAll(' ', '');
                                //   await shellFunction(
                                //     context,
                                //     toExecute: () async {
                                //       await d.updateDocument(
                                //         e.key,
                                //         imgPath!,
                                //         context.read<PxDoctor>().doctor!.id,
                                //         fileName: fileName,
                                //       );
                                //     },
                                //   );
                                // }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()
          ],
        );
      },
    );
  }
}
