import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/city.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/models/governorate.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateClinicPage extends StatefulWidget {
  const CreateClinicPage({super.key});

  @override
  State<CreateClinicPage> createState() => _CreateClinicPageState();
}

class _CreateClinicPageState extends State<CreateClinicPage> {
  final _formKey = GlobalKey<FormState>();

  int? _maxLength(String value) {
    switch (value) {
      case 'mobile':
        return 11;
      case 'landline':
        return 8;
      default:
        return null;
    }
  }

  bool _sideValidators(String e) {
    if (e == 'mobile' ||
        e == 'landline' ||
        e == 'consultation_fees' ||
        e == 'followup_fees' ||
        e == 'discount') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Clinic'),
      ),
      body: Consumer2<PxLocale, PxClinics>(
        builder: (context, l, c, child) {
          final isEnglish = l.locale.languageCode == 'en';
          return Form(
            key: _formKey,
            child: ListView(
              cacheExtent: 5000,
              children: [
                ...Clinic.editableStrings.map((e) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: Clinic.keyToWidget(e, isEnglish),
                          border: const OutlineInputBorder(),
                          suffix: const SizedBox(
                            height: 24,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Empty Fields are not Allowed.";
                          }
                          return null;
                        },
                        maxLength: _maxLength(e),
                        keyboardType: _sideValidators(e)
                            ? TextInputType.phone
                            : TextInputType.text,
                        inputFormatters: [
                          if (_sideValidators(e))
                            FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          c.setClinicFromKeyValue(e, value.trim());
                        },
                      ),
                    ),
                  );
                }).toList(),
                ...Clinic.editableDropdowns.map((e) {
                  return switch (e) {
                    'gov_en' => Consumer<PxGov>(
                        builder: (context, g, c) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('Select Governorate'),
                                subtitle: DropdownButtonFormField<Governorate>(
                                  items: g.govs?.map((e) {
                                    return DropdownMenuItem<Governorate>(
                                      value: e,
                                      alignment: Alignment.center,
                                      child: Text(
                                        e.governorate_name_en,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                  value: g.selectedGov,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Select Governorate.';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    g.selectGov(val);
                                    context.read<PxClinics>().setClinic(
                                          gov_en: val?.governorate_name_en,
                                          gov_ar: val?.governorate_name_ar,
                                          gov_id: val?.id,
                                        );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    'city_en' => Consumer<PxGov>(
                        builder: (context, gov, child) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('Select City'),
                                subtitle: DropdownButtonFormField<City>(
                                  items: gov.selectedGov?.cities.map((e) {
                                    return DropdownMenuItem<City>(
                                      value: e,
                                      alignment: Alignment.center,
                                      child: Text(
                                        e.city_name_en,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                  value: gov.selectedCity,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Select City.';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    gov.selectCity(val);
                                    context.read<PxClinics>().setClinic(
                                          city_en: val?.city_name_en,
                                          city_ar: val?.city_name_ar,
                                          city_id: val?.id,
                                        );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    "attendance" => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: const Text('Select Attendance.'),
                            subtitle: DropdownButtonFormField<bool>(
                              items: [true, false].map(
                                (e) {
                                  return DropdownMenuItem<bool>(
                                    value: e,
                                    alignment: Alignment.center,
                                    child: Text(
                                      e == false ? "FiFo" : "By Time",
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Select Attendance Type.';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                context.read<PxClinics>().setClinic(
                                      attendance: val,
                                    );
                              },
                            ),
                          ),
                        ),
                      ),
                    _ => const SizedBox(),
                  };
                }).toList(),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // validate fields
                        if (_formKey.currentState!.validate()) {
                          // populate default fields from doctor model
                          c.setClinic(
                            doc_id: context.read<PxDoctor>().doctor.id,
                            speciality_en:
                                context.read<PxDoctor>().doctor.speciality_en,
                            speciality_ar:
                                context.read<PxDoctor>().doctor.speciality_ar,
                            spec_id: context.read<PxDoctor>().doctor.spec_id,
                            published: false,
                            off_dates: [],
                          );
                          // send create clinic request
                          await shellFunction(context, toExecute: () async {
                            await c.createClinic();
                          });
                          if (mounted) {
                            GoRouter.of(context).pop();
                          }
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Create'),
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
                      icon: const Icon(Icons.arrow_back_ios),
                      label: const Text('Back'),
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
