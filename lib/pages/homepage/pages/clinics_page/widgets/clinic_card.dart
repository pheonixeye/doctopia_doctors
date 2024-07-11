import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:doctopia_doctors/components/prompt_dialog.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ClinicCard extends StatefulWidget {
  const ClinicCard({super.key, required this.clinic});
  final Clinic clinic;

  @override
  State<ClinicCard> createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard> {
  //TODO: add location to destination
  static const _textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(),
    suffix: SizedBox(
      height: 24,
    ),
  );

  bool _isIntegerKey(String key) {
    switch (key) {
      case 'consultation_fees' ||
            'followup_fees' ||
            'discount' ||
            "followup_duration":
        return true;
      default:
        return false;
    }
  }

  Map<String, bool> isEditing =
      Clinic.initial().toJson().map<String, bool>((k, v) => MapEntry(k, false));

  final Map<String, (TextEditingController, GlobalKey<FormFieldState>)>
      _controllers = Map.fromEntries(
    Clinic.editableStrings.map(
      (e) =>
          MapEntry(e, (TextEditingController(), GlobalKey<FormFieldState>())),
    ),
  );

  final Map<String, String? Function(String?)> _validators = Map.fromEntries(
    Clinic.editableStrings.map(
      (e) => MapEntry(e, (value) {
        if (value == null || value.isEmpty) {
          return 'Empty Fields are not Allowed.';
        }
        return null;
      }),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PxClinics>(
          builder: (context, c, _) {
            return ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FloatingActionButton.small(
                      heroTag: widget.clinic.hashCode,
                      onPressed: null,
                      child: widget.clinic.published
                          ? const Icon(Icons.public_sharp)
                          : const Icon(Icons.public_off),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(widget.clinic.name_en),
                    ),
                  ],
                ),
              ),
              children: [
                ...widget.clinic.toJson().entries.map((x) {
                  if (!Clinic.editableStrings.contains(x.key)) {
                    return const SizedBox();
                  }
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(Clinic.keyToWidget(x.key, true)),
                        subtitle: isEditing[x.key]!
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      key: _controllers[x.key]!.$2,
                                      controller: _controllers[x.key]!.$1,
                                      decoration: _textFieldDecoration,
                                      validator: _validators[x.key],
                                      keyboardType: _isIntegerKey(x.key)
                                          ? TextInputType.number
                                          : TextInputType.text,
                                      inputFormatters: [
                                        if (_isIntegerKey(x.key))
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                      ],
                                    ),
                                    const Gap(10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            // validate field using it's key
                                            if (_controllers[x.key]!
                                                .$2
                                                .currentState!
                                                .validate()) {
                                              // send update field request
                                              await shellFunction(
                                                context,
                                                toExecute: () async {
                                                  await c.updateClinic(
                                                      widget.clinic.id, {
                                                    x.key: _isIntegerKey(x.key)
                                                        ? int.parse(
                                                            _controllers[x.key]!
                                                                .$1
                                                                .text)
                                                        : _controllers[x.key]!
                                                            .$1
                                                            .text
                                                  });
                                                },
                                              );
                                            }
                                            //return to non editing state after editing
                                            setState(() {
                                              isEditing[x.key] = false;
                                            });
                                          },
                                          icon: const Icon(Icons.update),
                                          label: const Text("Update"),
                                        ),
                                        const Gap(10),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              isEditing[x.key] = false;
                                            });
                                          },
                                          icon: const Icon(Icons.close),
                                          label: const Text("Cancel"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SelectableText(x.value.toString()),
                              ),
                        trailing: !isEditing[x.key]!
                            ? FloatingActionButton.small(
                                heroTag: x.key,
                                onPressed: () {
                                  setState(() {
                                    isEditing[x.key] = !isEditing[x.key]!;
                                    _controllers[x.key]!.$1.text =
                                        x.value.toString();
                                  });
                                },
                                child: const Icon(Icons.edit),
                              )
                            : null,
                      ),
                    ),
                  );
                }).toList(),
                // ClinicImagesTile(
                //   //find why it gets the same images despite having different ids
                //   clinic_id: e.id,
                //   key: ValueKey(e.id),
                // ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // navigate to schedule management page
                            if (context.mounted) {
                              c.selectClinic(widget.clinic);
                              GoRouter.of(context).goNamed(
                                AppRouter.sch,
                                pathParameters: {
                                  "id": widget.clinic.doc_id,
                                  "clinicid": widget.clinic.id,
                                },
                              );
                            }
                          },
                          label: const Text('Schedule'),
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            // check if clinic schedule is created
                            final _sch = widget.clinic.schedule;
                            final _hasSchSet =
                                _sch.any((s) => s.available == true);
                            if (_hasSchSet && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  iInfoSnackbar(
                                      'Add Clinic Schedule First.', context));
                            }

                            // testing update algorithm<working>
                            // publish clinic
                            else {
                              if (context.mounted) {
                                await shellFunction(context,
                                    toExecute: () async {
                                  await c.updateClinic(widget.clinic.id, {
                                    'published': !widget.clinic.published,
                                  });
                                });
                              }
                            }
                          },
                          label: !widget.clinic.published
                              ? const Text('Publish')
                              : const Text('UnPublish'),
                          icon: !widget.clinic.published
                              ? const Icon(Icons.publish)
                              : const Icon(Icons.unpublished),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Builder(builder: (context) {
                          return ElevatedButton.icon(
                            onPressed: () async {
                              final oldDest = widget.clinic.destination;
                              bool isInitial =
                                  oldDest.lat == 0 && oldDest.lon == 0;
                              GeoPoint? p = await showSimplePickerLocation(
                                context: context,
                                isDismissible: true,
                                title: "Pick Clinic Location",
                                textConfirmPicker: "Confirm",
                                radius: 12,
                                initPosition: isInitial
                                    ? GeoPoint(
                                        latitude: 30,
                                        longitude: 31,
                                      )
                                    : GeoPoint(
                                        latitude: oldDest.lat,
                                        longitude: oldDest.lon,
                                      ),
                              );
                              if (p != null && context.mounted) {
                                final newDest =
                                    widget.clinic.destination.copyWith(
                                  lat: p.latitude,
                                  lon: p.longitude,
                                );
                                await shellFunction(
                                  context,
                                  toExecute: () async {
                                    await c.updateClinic(
                                      widget.clinic.id,
                                      {
                                        "destination": newDest.toJson(),
                                      },
                                    );
                                  },
                                );
                              }
                            },
                            label: const Text('Set Location'),
                            icon: const Icon(Icons.pin_drop),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            // show confirm delete clinic dialog
                            final bool? result = await showDialog<bool?>(
                              context: context,
                              builder: (context) {
                                return const MainPromptDialog(
                                  title: 'Delete Clinic ?',
                                  body:
                                      "This is an irreversible action, Are you sure ?",
                                );
                              },
                            );

                            if (result != null && result) {
                              if (context.mounted) {
                                await shellFunction(context,
                                    toExecute: () async {
                                  await c.deleteClinic(widget.clinic, context);
                                });
                              }
                            }
                          },
                          label: const Text('Delete Clinic'),
                          icon: const Icon(Icons.delete_forever),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
              ],
            );
          },
        ),
      ),
    );
  }
}
