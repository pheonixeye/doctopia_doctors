// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:typed_data';

import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/pages/homepage/pages/clinics_page/widgets/image_viewer_dialog.dart';
import 'package:doctopia_doctors/providers/px_clinic_images.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicImagesTile extends StatefulWidget {
  const ClinicImagesTile({super.key, required this.clinic_id});
  final String clinic_id;

  @override
  State<ClinicImagesTile> createState() => _ClinicImagesTileState();
}

class _ClinicImagesTileState extends State<ClinicImagesTile> {
  late final List<String> _links;

  Future<void> _initImages() async {
    try {
      final _res = await context
          .read<PxClinicImages>()
          .fetchClinicImages(widget.clinic_id);
      setState(() {
        _links = _res.images;
      });
    } catch (e) {
      setState(() {
        _links = [];
      });
    }
  }

  @override
  void initState() {
    _initImages();
    super.initState();
  }

  bool _isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: const Text('Clinic Images'),
          trailing: FloatingActionButton.small(
            heroTag: 'images-edit-key',
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child:
                _isEditing ? const Icon(Icons.close) : const Icon(Icons.edit),
          ),
          subtitle: _isEditing
              ? Consumer2<PxClinics, PxClinicImages>(
                  builder: (context, c, i, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            if (i.images == null)
                              const SizedBox()
                            else
                              ..._links.map((e) {
                                return SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: FutureBuilder<Uint8List>(
                                      future:
                                          i.clinicImagesService.fetchImage(e),
                                      builder: (context, snapshot) {
                                        while (!snapshot.hasData) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Hero(
                                              tag: e,
                                              child:
                                                  Image.memory(snapshot.data!),
                                            ),
                                            IconButton.filledTonal(
                                              icon: const Icon(Icons.search),
                                              onPressed: () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ImageViewerDialog(
                                                      image: Image.memory(
                                                        snapshot.data!,
                                                      ),
                                                      id: e,
                                                      clinic_id:
                                                          widget.clinic_id,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      }),
                                );
                              }).toList(),
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: FloatingActionButton(
                                heroTag: 'add-image-${widget.clinic_id}',
                                onPressed: () async {
                                  late String? imgPath;
                                  final FilePickerResult? _pickedFiles =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                  );
                                  if (_pickedFiles != null) {
                                    imgPath = _pickedFiles.files.first.path;
                                  }
                                  if (imgPath != null && mounted) {
                                    final fileName =
                                        '${widget.clinic_id}-${DateTime.now().toIso8601String()}.${_pickedFiles!.files.first.extension}';

                                    await shellFunction(
                                      context,
                                      toExecute: () async {
                                        await i.addClinicImage(
                                          imgPath!,
                                          widget.clinic_id,
                                          fileName: fileName,
                                        );
                                      },
                                    );
                                  }
                                },
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : null,
        ),
      ),
    );
  }
}
