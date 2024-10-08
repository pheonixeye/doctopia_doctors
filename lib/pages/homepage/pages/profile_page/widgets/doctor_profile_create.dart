// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/functions/dprint.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proklinik_models/models/degree.dart';
import 'package:proklinik_models/models/speciality.dart';
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
  late final TextEditingController _synd_idController;
  late final TextEditingController _personal_phoneController;

  @override
  void initState() {
    _name_enController = TextEditingController();
    _name_arController = TextEditingController();
    _title_enController = TextEditingController();
    _title_arController = TextEditingController();
    _about_enController = TextEditingController();
    _about_arController = TextEditingController();
    _synd_idController = TextEditingController();
    _personal_phoneController = TextEditingController();

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
    _synd_idController.dispose();
    _personal_phoneController.dispose();
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
    return Consumer3<PxUserModel, PxDoctor, PxLocale>(
      builder: (context, u, d, l, _) {
        while (u.model == null) {
          return const Center(
            child: CentralLoading(),
          );
        }
        return Form(
          key: formKey,
          child: ListView(
            children: [
              const Gap(10),
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
                      subtitle: Consumer<PxSpeciality>(
                        builder: (context, s, _) {
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
                              items: s.specialities.map((e) {
                                return DropdownMenuItem<Speciality>(
                                  alignment: Alignment.center,
                                  value: e,
                                  child: Text(e.en),
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
                      title: Text(context.loc.medicalDegree),
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
                          items: Degree.list.map((e) {
                            return DropdownMenuItem<Degree>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(e.en),
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
                        validator: _validator,
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.arabicAbout),
                      subtitle: TextFormField(
                        controller: _about_arController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: _validator,
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
                      late BuildContext _loadingContext;
                      d.setDoctor(
                        synd_id: u.model?.synd_id,
                        personal_phone: u.model?.phone,
                        name_en: _name_enController.text.trim(),
                        name_ar: _name_arController.text.trim(),
                        title_en: _title_enController.text.trim(),
                        title_ar: _title_arController.text.trim(),
                        about_en: _about_enController.text.trim(),
                        about_ar: _about_arController.text.trim(),
                        speciality_en: _speciality!.en,
                        speciality_ar: _speciality!.ar,
                        degree_en: _degree!.en,
                        degree_ar: _degree!.ar,
                      );
                      try {
                        showDialog(
                          context: context,
                          builder: (context) {
                            _loadingContext = context;
                            return const CentralLoading();
                          },
                        );
                        await d.createDoctor();
                        if (_loadingContext.mounted) {
                          Navigator.pop(_loadingContext);
                        }
                      } catch (e) {
                        d.nullifyDoctor();
                        if (_loadingContext.mounted) {
                          Navigator.pop(_loadingContext);
                        }
                        dprint(e);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 10),
                            content: Text(
                              e.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ));
                        }
                      }
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
