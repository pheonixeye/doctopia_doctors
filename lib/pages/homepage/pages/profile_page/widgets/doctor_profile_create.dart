// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/degree.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/speciality.dart';
import 'package:doctopia_doctors/providers/px_app_constants.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DoctorProfileCreate extends StatefulWidget {
  const DoctorProfileCreate({super.key});

  @override
  State<DoctorProfileCreate> createState() => _DoctorProfileCreateState();
}

class _DoctorProfileCreateState extends State<DoctorProfileCreate> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _name_enController;
  late final TextEditingController _name_arController;
  late final TextEditingController _title_enController;
  late final TextEditingController _title_arController;
  late final TextEditingController _about_enController;
  late final TextEditingController _about_arController;

  @override
  void initState() {
    _name_enController = TextEditingController();
    _name_arController = TextEditingController();
    _title_enController = TextEditingController();
    _title_arController = TextEditingController();
    _about_enController = TextEditingController();
    _about_arController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name_enController.dispose();
    _name_arController.dispose();
    _title_enController.dispose();
    _title_arController.dispose();
    _about_enController.dispose();
    _about_arController.dispose();
    super.dispose();
  }

  Speciality? _speciality;
  Degree? _degree;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.emptyInputsNotAllowed;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<PxUserModel, PxDoctor, PxLocale, PxAppConstants>(
      builder: (context, u, d, l, a, _) {
        while (u.model == null || a.model == null) {
          return const Center(
            child: CentralLoading(),
          );
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
              Card.outlined(
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.englishName),
                      subtitle: TextFormField(
                        controller: _name_enController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: _validator,
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.arabicName),
                      subtitle: TextFormField(
                        controller: _name_arController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: _validator,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Card.outlined(
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.speciality),
                      subtitle: Builder(
                        builder: (context) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<Speciality>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              value: _speciality,
                              validator: (value) {
                                if (value == null) {
                                  return context.loc.specialityValidator;
                                }
                                return null;
                              },
                              isExpanded: true,
                              alignment: Alignment.center,
                              items: a.model?.specialities.map((e) {
                                return DropdownMenuItem<Speciality>(
                                  alignment: Alignment.center,
                                  value: e,
                                  child:
                                      Text(l.isEnglish ? e.name_en : e.name_ar),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _speciality = value;
                                  });
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Card.outlined(
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.practicalDegree),
                      subtitle: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<Degree>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return context.loc.medicalDegreeValidator;
                            }
                            return null;
                          },
                          value: _degree,
                          isExpanded: true,
                          alignment: Alignment.center,
                          items: a.model?.degrees.map((e) {
                            return DropdownMenuItem<Degree>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(l.isEnglish ? e.name_en : e.name_ar),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _degree = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Card.outlined(
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.englishTitle),
                      subtitle: TextFormField(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: _validator,
                        controller: _title_enController,
                        maxLines: 2,
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.arabicTitle),
                      subtitle: TextFormField(
                        controller: _title_arController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: _validator,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Card.outlined(
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.englishAbout),
                      subtitle: TextFormField(
                        controller: _about_enController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        // validator: _validator,
                        maxLines: 4,
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.arabicAbout),
                      subtitle: TextFormField(
                        controller: _about_arController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        // validator: _validator,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      d.setDoctor(
                        id: u.model?.userModel.id,
                        synd_id: u.model?.userModel.synd_id,
                        personal_phone: u.model?.userModel.phone,
                        name_en: _name_enController.text.trim(),
                        name_ar: _name_arController.text.trim(),
                        title_en: _title_enController.text.trim(),
                        title_ar: _title_arController.text.trim(),
                        about_en: _about_enController.text.trim(),
                        about_ar: _about_arController.text.trim(),
                        speciality: _speciality,
                        degree: _degree,
                      );
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await d.createDoctor();
                        },
                      );
                    }
                  },
                  label: Text(context.loc.save),
                  icon: const Icon(Icons.save),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
