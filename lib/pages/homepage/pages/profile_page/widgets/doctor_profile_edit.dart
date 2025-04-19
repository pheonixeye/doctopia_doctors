import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/degree.dart';
import 'package:doctopia_doctors/models/doctor_response_model/doctor_response_model.dart';
import 'package:doctopia_doctors/models/doctor_response_model/widgets_ext.dart';
import 'package:doctopia_doctors/providers/px_app_constants.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DoctorProfileEdit extends StatefulWidget {
  const DoctorProfileEdit({super.key});

  @override
  State<DoctorProfileEdit> createState() => _DoctorProfileEditState();
}

class _DoctorProfileEditState extends State<DoctorProfileEdit> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;

  final formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      DoctorResponseModel.initial().editableStrings(context).entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      DoctorResponseModel.initial().editableStrings(context).entries.map(
            (entry) => MapEntry<String, TextEditingController>(
              entry.key,
              TextEditingController(),
            ),
          ),
    );
    super.didChangeDependencies();
  }

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.emptyInputsNotAllowed;
    }
    return null;
  }

  int _maxLines(String key) {
    return switch (key) {
      'name_en' || 'name_ar' => 1,
      'title_en' || 'title_ar' => 2,
      'about_en' || 'about_ar' => 4,
      _ => 1
    };
  }

  Widget _toggleButton(String key) {
    return IconButton.outlined(
      onPressed: () {
        setState(() {
          _isEditing[key] == true
              ? _isEditing[key] = false
              : _isEditing[key] = true;
        });
      },
      icon: Icon(_isEditing[key] == true ? Icons.close : Icons.edit),
    );
  }

  @override
  void dispose() {
    _controllers.entries.map((e) => e.value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<PxAppConstants, PxDoctor, PxLocale>(
      builder: (context, a, d, l, _) {
        while (a.model == null || d.doctor == null) {
          return const CentralLoading();
        }
        return Form(
          key: formKey,
          child: ListView(
            cacheExtent: 3000,
            children: [
              ListTile(
                title: Text(context.loc.profile),
                subtitle: const Divider(),
              ),
              ...DoctorResponseModel.initial()
                  .editableStrings(context)
                  .entries
                  .map(
                (entry) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card.outlined(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(entry.value),
                          subtitle: entry.key == 'degree_id'
                              ? Row(
                                  children: [
                                    if (_isEditing[entry.key] == true) ...[
                                      Expanded(
                                        child: DropdownButtonFormField<Degree>(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          alignment: Alignment.center,
                                          value: d.doctor?.degree,
                                          items: a.model?.degrees.map((deg) {
                                            return DropdownMenuItem<Degree>(
                                              value: deg,
                                              alignment: Alignment.center,
                                              child: Text(
                                                l.isEnglish
                                                    ? deg.name_en
                                                    : deg.name_ar,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) async {
                                            await shellFunction(
                                              context,
                                              toExecute: () async {
                                                await d.updateDoctor(
                                                  {
                                                    entry.key: value?.id,
                                                  },
                                                );
                                                setState(() {
                                                  _isEditing[entry.key] = false;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ] else
                                      Expanded(
                                        child: Text(l.isEnglish
                                            ? '${d.doctor?.toJson()['degree']['name_en']}'
                                            : '${d.doctor?.toJson()['degree']['name_ar']}'),
                                      ),
                                    _toggleButton(entry.key),
                                    const SizedBox(width: 5),
                                  ],
                                )
                              : Row(
                                  children: [
                                    if (_isEditing[entry.key] == true) ...[
                                      Expanded(
                                        child: TextFormField(
                                          inputFormatters: [
                                            if (entry.key == 'personal_phone')
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                          ],
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          maxLines: _maxLines(entry.key),
                                          validator: _validator,
                                          controller: _controllers[entry.key]
                                            ?..text =
                                                d.doctor?.toJson()[entry.key],
                                        ),
                                      ),
                                      IconButton.outlined(
                                        onPressed: () async {
                                          if (!formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          await shellFunction(
                                            context,
                                            toExecute: () async {
                                              await d.updateDoctor(
                                                {
                                                  entry.key:
                                                      _controllers[entry.key]
                                                          ?.text,
                                                },
                                              );
                                              setState(() {
                                                _isEditing[entry.key] = false;
                                              });
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.save),
                                      ),
                                    ] else
                                      Expanded(
                                        child: Text(
                                            '${d.doctor?.toJson()[entry.key]}'),
                                      ),
                                    _toggleButton(entry.key),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
