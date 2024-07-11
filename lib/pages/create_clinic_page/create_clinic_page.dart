import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/city.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/models/governorate.dart';
import 'package:doctopia_doctors/models/schedule/schedule.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/foundation.dart';
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

  Clinic? _clinic;

  void setClinicFromKeyValue(String key, dynamic value) {
    _clinic ??= Clinic.initial();
    switch (key) {
      case 'name_en':
        _clinic = _clinic?.copyWith(
          name_en: value,
        );

        break;
      case 'name_ar':
        _clinic = _clinic?.copyWith(
          name_ar: value,
        );

        break;
      case 'address_en':
        _clinic = _clinic?.copyWith(
          address_en: value,
        );
        break;
      case 'address_ar':
        _clinic = _clinic?.copyWith(
          address_ar: value,
        );
        break;
      case 'gov_en':
        _clinic = _clinic?.copyWith(
          gov_en: value,
        );
        break;
      case 'gov_ar':
        _clinic = _clinic?.copyWith(
          gov_ar: value,
        );
        break;
      case 'area_en':
        _clinic = _clinic?.copyWith(
          city_en: value,
        );
        break;
      case 'area_ar':
        _clinic = _clinic?.copyWith(
          city_ar: value,
        );
        break;
      case 'lon':
        _clinic = _clinic?.copyWith(
          lon: double.tryParse(value),
        );
        break;
      case 'lat':
        _clinic = _clinic?.copyWith(
          lat: double.tryParse(value),
        );
        break;

      case 'mobile':
        _clinic = _clinic?.copyWith(
          mobile: value,
        );
        break;
      case 'landline':
        _clinic = _clinic?.copyWith(
          landline: value,
        );
        break;

      case 'consultation_fees':
        _clinic = _clinic?.copyWith(
          consultation_fees: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      case 'followup_fees':
        _clinic = _clinic?.copyWith(
          followup_fees: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      case 'followup_duration':
        _clinic = _clinic?.copyWith(
          followup_duration: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      case 'discount':
        _clinic = _clinic?.copyWith(
          discount: value.isEmpty ? 0 : int.tryParse(value),
        );
        break;
      case 'attendance':
        _clinic = _clinic?.copyWith(
          attendance: value as bool,
        );
        break;
      default:
        return;
    }
    if (kDebugMode) {
      // print(_clinic);
    }
  }

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
        e == 'followup_duration' ||
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
        builder: (context, l, c, _) {
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
                          setClinicFromKeyValue(e, value.trim());
                        },
                      ),
                    ),
                  );
                }).toList(),
                ...Clinic.editableDropdowns.map((e) {
                  return switch (e) {
                    'gov_en' => Consumer<PxGov>(
                        builder: (context, g, _) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('Select Governorate'),
                                subtitle: DropdownButtonFormField<Governorate>(
                                  isExpanded: true,
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
                                    // c.setClinic(
                                    //   gov_en: val?.governorate_name_en,
                                    //   gov_ar: val?.governorate_name_ar,
                                    // );
                                    if (val != null) {
                                      setClinicFromKeyValue(
                                          e, val.governorate_name_en);
                                      setClinicFromKeyValue(
                                          "gov_ar", val.governorate_name_ar);
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    'area_en' => Consumer<PxGov>(
                        builder: (context, gov, _) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('Select Area'),
                                subtitle: DropdownButtonFormField<City>(
                                  isExpanded: true,
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
                                      return 'Select Area.';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    gov.selectCity(val);
                                    if (val != null) {
                                      setClinicFromKeyValue(
                                          e, val.city_name_en);
                                      setClinicFromKeyValue(
                                          "area_ar", val.city_name_ar);
                                    }
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
                              isExpanded: true,
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
                                if (val != null) {
                                  setClinicFromKeyValue(e, val);
                                }
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
                          final _clinic = this._clinic?.copyWith(
                                doc_id: c.id,
                                schedule: Schedule.initialClinicSchedule,
                              );
                          // send create clinic request
                          await shellFunction(context, toExecute: () async {
                            await c.createClinic(_clinic!);
                          });
                          if (context.mounted) {
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
