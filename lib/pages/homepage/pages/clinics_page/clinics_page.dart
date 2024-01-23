// ignore_for_file: prefer_final_fields

import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  static const _textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(),
    suffix: SizedBox(
      height: 24,
    ),
  );

  bool _isIntegerKey(String key) {
    switch (key) {
      case 'consultation_fees' || 'followup_fees' || 'discount':
        return true;
      default:
        return false;
    }
  }

  Map<String, bool> isEditing =
      Clinic.initial().toJson().map<String, bool>((k, v) => MapEntry(k, false));

  Map<String, (TextEditingController, GlobalKey<FormFieldState>)> _controllers =
      Map.fromEntries(
    Clinic.editableStrings.map(
      (e) =>
          MapEntry(e, (TextEditingController(), GlobalKey<FormFieldState>())),
    ),
  );

  Map<String, String? Function(String?)> _validators = Map.fromEntries(
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
    return ListView(
      cacheExtent: 3000,
      children: [
        const ListTile(
          leading: CircleAvatar(),
          title: Text('My Clinics'),
        ),
        Consumer2<PxLocale, PxClinics>(
          builder: (context, l, c, child) {
            final bool isEnglish = l.locale.languageCode == 'en';
            while (c.clinics.isEmpty) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(250),
                  Center(
                    child: Text('No Clinics Created Yet.'),
                  ),
                ],
              );
            }
            return Column(
              children: [
                ...c.clinics.map((record) {
                  final e = record.clinic;
                  final id = record.id;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              FloatingActionButton.small(
                                heroTag: e.hashCode,
                                onPressed: null,
                                child: e.published
                                    ? const Icon(Icons.check)
                                    : const Icon(Icons.close),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Text(isEnglish ? e.name_en : e.name_ar),
                              ),
                            ],
                          ),
                        ),
                        children: [
                          ...e.toJson().entries.map((x) {
                            if (!Clinic.editableStrings.contains(x.key)) {
                              return const SizedBox();
                            }
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                      Clinic.keyToWidget(x.key, isEnglish)),
                                  subtitle: isEditing[x.key]!
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                key: _controllers[x.key]!.$2,
                                                controller:
                                                    _controllers[x.key]!.$1,
                                                decoration:
                                                    _textFieldDecoration,
                                                validator: _validators[x.key],
                                                keyboardType:
                                                    _isIntegerKey(x.key)
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
                                                      //TODO: validate field using it's key
                                                      if (_controllers[x.key]!
                                                          .$2
                                                          .currentState!
                                                          .validate()) {
                                                        //TODO: send update field request
                                                        await shellFunction(
                                                          context,
                                                          toExecute: () async {
                                                            await c
                                                                .updateClinic(
                                                                    id, {
                                                              x.key: _isIntegerKey(
                                                                      x.key)
                                                                  ? int.parse(
                                                                      _controllers[x
                                                                              .key]!
                                                                          .$1
                                                                          .text)
                                                                  : _controllers[
                                                                          x.key]!
                                                                      .$1
                                                                      .text
                                                            });
                                                          },
                                                        );
                                                      }
                                                      //return to non editing state after editing
                                                      setState(() {
                                                        isEditing[x.key] =
                                                            false;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.update),
                                                    label: const Text("Update"),
                                                  ),
                                                  const Gap(10),
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      setState(() {
                                                        isEditing[x.key] =
                                                            false;
                                                      });
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
                                                    label: const Text("Cancel"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SelectableText(
                                              x.value.toString()),
                                        ),
                                  trailing: !isEditing[x.key]!
                                      ? FloatingActionButton.small(
                                          heroTag: x.key,
                                          onPressed: () {
                                            setState(() {
                                              isEditing[x.key] =
                                                  !isEditing[x.key]!;
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
                          const Gap(10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    //TODO: show set schedule dialog
                                  },
                                  label: const Text('Schedule'),
                                  icon: const Icon(Icons.calendar_month),
                                ),
                                const Gap(10),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    // publish clinic

                                    // testing update algorithm<working>
                                    await shellFunction(context,
                                        toExecute: () async {
                                      await c.updateClinic(id, {
                                        'published': !e.published,
                                      });
                                    });
                                  },
                                  label: const Text('Publish'),
                                  icon: const Icon(Icons.publish),
                                ),
                              ],
                            ),
                          ),
                          const Gap(60),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),
      ],
    );
  }
}
