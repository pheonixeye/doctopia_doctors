import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_response_model.dart';
import 'package:doctopia_doctors/providers/px_app_constants.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_models/models/schedule.dart';
import 'package:provider/provider.dart';

class CreateClinicPage extends StatefulWidget {
  const CreateClinicPage({super.key});

  @override
  State<CreateClinicPage> createState() => _CreateClinicPageState();
}

class _CreateClinicPageState extends State<CreateClinicPage> {
  late final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  String? _governorate_id;
  String? _city_id;
  String? _attendance_type_id;

  int? _maxLength(String key) {
    return switch (key) {
      'mobile' => 11,
      'landline' => 8,
      _ => null,
    };
  }

  TextInputType? _keyboardType(String key) {
    return switch (key) {
      'mobile' ||
      'landline' ||
      'consultation_fees' ||
      'followup_fees' ||
      'followup_duration' ||
      'discount' =>
        TextInputType.number,
      _ => TextInputType.text,
    };
  }

  bool _inputFormatters(String key) {
    return switch (key) {
      'mobile' ||
      'landline' ||
      'consultation_fees' ||
      'followup_fees' ||
      'followup_duration' ||
      'discount' =>
        true,
      _ => false,
    };
  }

  @override
  void didChangeDependencies() {
    _controllers = Map.fromEntries(
      ClinicResponseModel.editableStrings(context).entries.map(
            (e) => MapEntry<String, TextEditingController>(
                e.key, TextEditingController()),
          ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.entries.map((e) => e.value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer3<PxLocale, PxClinics, PxAppConstants>(
        builder: (context, l, c, a, _) {
          while (a.model == null) {
            return const CentralLoading();
          }
          return Form(
            key: _formKey,
            child: ListView(
              cacheExtent: 5000,
              children: [
                ListTile(
                  title: Text(context.loc.createClinic),
                  subtitle: const Divider(),
                ),
                ..._controllers.entries.map((entry) {
                  return Card.outlined(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: ClinicResponseModel.editableStrings(
                              context)[entry.key],
                          border: const OutlineInputBorder(),
                          suffix: const SizedBox(
                            height: 24,
                          ),
                        ),
                        controller: entry.value,
                        maxLines: entry.key.contains('address') ? 3 : null,
                        validator: entry.key == 'landline'
                            ? null
                            : (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return context.loc.emptyInputsNotAllowed;
                                }
                                return null;
                              },
                        maxLength: _maxLength(entry.key),
                        keyboardType: _keyboardType(entry.key),
                        inputFormatters: [
                          if (_inputFormatters(entry.key))
                            FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  );
                }),
                ...ClinicResponseModel.editableDropdowns(context)
                    .entries
                    .map((entry) {
                  return Card.outlined(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        alignment: Alignment.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: entry.value,
                        ),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                        iconEnabledColor: Theme.of(context).primaryColor,
                        value: switch (entry.key) {
                          'governorate_id' => _governorate_id,
                          'city_id' => _city_id,
                          'attendance_type_id' => _attendance_type_id,
                          _ => null,
                        },
                        validator: (value) {
                          if (value == null) {
                            return context.loc.emptyInputsNotAllowed;
                          }
                          return null;
                        },
                        items: switch (entry.key) {
                          'governorate_id' => a.model?.governorates.map((gov) {
                              return DropdownMenuItem<String>(
                                value: gov.id,
                                alignment: Alignment.center,
                                child: Text(
                                  l.isEnglish ? gov.name_en : gov.name_ar,
                                ),
                              );
                            }).toList(),
                          'city_id' => a.model?.cities
                                .where(
                                    (c) => c.governorate_id == _governorate_id)
                                .map((city) {
                              return DropdownMenuItem<String>(
                                value: city.id,
                                alignment: Alignment.center,
                                child: Text(
                                  l.isEnglish ? city.name_en : city.name_ar,
                                ),
                              );
                            }).toList(),
                          'attendance_type_id' =>
                            a.model?.attendance_types.map((att) {
                              return DropdownMenuItem<String>(
                                value: att.id,
                                alignment: Alignment.center,
                                child: Text(
                                  l.isEnglish ? att.name_en : att.name_ar,
                                ),
                              );
                            }).toList(),
                          _ => null,
                        },
                        onChanged: (value) {
                          switch (entry.key) {
                            case 'governorate_id':
                              setState(() {
                                _governorate_id = value;
                                _city_id = null;
                              });
                              break;
                            case 'city_id':
                              setState(() {
                                _city_id = value;
                              });
                              break;
                            case 'attendance_type_id':
                              _attendance_type_id = value;
                              break;
                          }
                        },
                      ),
                    ),
                  );
                }),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // validate fields
                        if (_formKey.currentState!.validate()) {
                          final _model = ClinicResponseModel(
                            id: '',
                            doc_id: c.doc_id,
                            name_en: _controllers['name_en']!.text,
                            name_ar: _controllers['name_ar']!.text,
                            address_en: _controllers['address_en']!.text,
                            address_ar: _controllers['address_ar']!.text,
                            location: {},
                            mobile: _controllers['mobile']!.text,
                            landline: _controllers['landline']!.text,
                            consultation_fees: int.parse(
                                _controllers['consultation_fees']!.text),
                            followup_fees:
                                int.parse(_controllers['followup_fees']!.text),
                            followup_duration: int.parse(
                                _controllers['followup_duration']!.text),
                            discount: int.parse(_controllers['discount']!.text),
                            governorate_id: _governorate_id!,
                            city_id: _city_id!,
                            speciality_id:
                                context.read<PxDoctor>().doctor!.speciality.id,
                            attendance_type_id: _attendance_type_id!,
                            venue_id: '',
                            schedule: Schedule.initialClinicSchedule
                                .map((e) => e.toJson())
                                .toList(),
                            off_dates: [],
                          );
                          // send create clinic request
                          await shellFunction(
                            context,
                            toExecute: () async {
                              await c.createClinic(_model);
                            },
                          );
                          if (context.mounted) {
                            GoRouter.of(context).goNamed(
                              AppRouter.clinics,
                              pathParameters: {
                                "id": c.doc_id,
                              },
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: Text(context.loc.createClinic),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      label: Text(context.loc.cancel),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
