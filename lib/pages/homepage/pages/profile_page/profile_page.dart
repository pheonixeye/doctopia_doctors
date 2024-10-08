// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/pages/profile_page/widgets/doctor_profile_create.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proklinik_models/models/degree.dart';
import 'package:proklinik_models/models/doctor.dart';
import 'package:proklinik_models/models/speciality.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Map<String, bool> _isEditing = {};

  final formKey = GlobalKey<FormState>();

  late final TextEditingController _name_enController;
  late final TextEditingController _name_arController;
  late final TextEditingController _title_enController;
  late final TextEditingController _title_arController;
  late final TextEditingController _about_enController;
  late final TextEditingController _about_arController;
  late final TextEditingController _synd_idController;
  late final TextEditingController _personal_phoneController;

  Speciality? _speciality;
  Degree? _degree;

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

    Doctor.emptyForCreate().toJson().entries.map((e) {
      _isEditing[e.key] = false;
    }).toList();

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

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.emptyInputsNotAllowed;
    }
    return null;
  }

  Future<void> _UpdateDoctorField(String key, dynamic value) async {
    final d = context.read<PxDoctor>();
    d.setUpdate(key, value);
    await d.updateDoctor();
  }

  Widget _updateBtnsRow(
    String field,
    TextEditingController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton.outlined(
            onPressed: () async {
              late BuildContext _loadingContext;
              try {
                showDialog(
                  context: context,
                  builder: (context) {
                    _loadingContext = context;
                    return const CentralLoading();
                  },
                );

                await _UpdateDoctorField(field, controller.text.trim());
                if (_loadingContext.mounted) {
                  Navigator.pop(_loadingContext);
                }
                setState(() {
                  _isEditing[field] = false;
                });
              } catch (e) {
                if (_loadingContext.mounted) {
                  Navigator.pop(_loadingContext);
                }

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
                setState(() {
                  _isEditing[field] = false;
                });
              }
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
          const Gap(20),
          IconButton.outlined(
            onPressed: () {
              setState(() {
                _isEditing[field] = false;
              });
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<PxUserModel, PxDoctor, PxLocale>(
      builder: (context, u, d, l, _) {
        while (d.doctor == null) {
          return const DoctorProfileCreate();
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
                      subtitle: (_isEditing["name_en"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _name_enController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                _updateBtnsRow(
                                  "name_en",
                                  _name_enController,
                                  context,
                                ),
                              ],
                            )
                          : Text(d.doctor!.name_en),
                      trailing: IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            _isEditing["name_en"] = !_isEditing["name_en"]!;
                          });
                        },
                        icon: Icon(
                            !_isEditing["name_en"]! ? Icons.edit : Icons.close),
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.arabicName),
                      subtitle: (_isEditing["name_ar"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _name_arController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                _updateBtnsRow(
                                  "name_ar",
                                  _name_arController,
                                  context,
                                ),
                              ],
                            )
                          : Text(d.doctor!.name_ar),
                      trailing: IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            _isEditing["name_ar"] = !_isEditing["name_ar"]!;
                          });
                        },
                        icon: Icon(
                            !_isEditing["name_ar"]! ? Icons.edit : Icons.close),
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
                      trailing: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.close,
                          color: Colors.transparent,
                        ),
                      ),
                      subtitle: (_isEditing["specialty_en"] == true)
                          ? Consumer<PxSpeciality>(
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
                                      setState(() {
                                        _speciality = value;
                                      });
                                    },
                                  ),
                                );
                              },
                            )
                          : Text(d.doctor!.speciality_en),
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
                      trailing: IconButton.outlined(
                          onPressed: () {
                            setState(() {
                              _isEditing["degree_en"] =
                                  !_isEditing["degree_en"]!;
                            });
                          },
                          icon: Icon(!_isEditing["degree_en"]!
                              ? Icons.edit
                              : Icons.close)),
                      subtitle: (_isEditing["degree_en"] == true)
                          ? DropdownButtonHideUnderline(
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
                                onChanged: (value) async {
                                  setState(() {
                                    _degree = value;
                                  });
                                  late BuildContext _loadingContext;
                                  if (value != null) {
                                    try {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          _loadingContext = context;
                                          return const CentralLoading();
                                        },
                                      );
                                      await _UpdateDoctorField(
                                          "degree_en", value.en);
                                      await _UpdateDoctorField(
                                          "degree_ar", value.ar);

                                      if (_loadingContext.mounted) {
                                        Navigator.pop(_loadingContext);
                                      }
                                    } catch (e) {
                                      if (_loadingContext.mounted) {
                                        Navigator.pop(_loadingContext);
                                      }

                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          iInfoSnackbar(
                                            e.toString(),
                                            context,
                                            Colors.red,
                                          ),
                                        );
                                      }

                                      setState(() {
                                        _isEditing["degree_en"] = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            )
                          : Text(d.doctor!.degree_en),
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
                      subtitle: (_isEditing["title_en"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                  controller: _title_enController,
                                ),
                                _updateBtnsRow(
                                  "title_en",
                                  _title_enController,
                                  context,
                                )
                              ],
                            )
                          : Text(d.doctor!.title_en),
                      trailing: IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            _isEditing["title_en"] = !_isEditing["title_en"]!;
                          });
                        },
                        icon: Icon(!_isEditing["title_en"]!
                            ? Icons.edit
                            : Icons.close),
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.arabicTitle),
                      subtitle: (_isEditing["title_ar"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _title_arController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                _updateBtnsRow(
                                  "title_ar",
                                  _title_arController,
                                  context,
                                )
                              ],
                            )
                          : Text(d.doctor!.title_ar),
                      trailing: IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            _isEditing["title_ar"] = !_isEditing["title_ar"]!;
                          });
                        },
                        icon: Icon(!_isEditing["title_ar"]!
                            ? Icons.edit
                            : Icons.close),
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
                      subtitle: (_isEditing["about_en"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _about_enController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                _updateBtnsRow(
                                  "about_en",
                                  _about_enController,
                                  context,
                                )
                              ],
                            )
                          : Text(d.doctor!.about_en),
                      trailing: IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            _isEditing["about_en"] = !_isEditing["about_en"]!;
                          });
                        },
                        icon: Icon(!_isEditing["about_en"]!
                            ? Icons.edit
                            : Icons.close),
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(context.loc.arabicAbout),
                      subtitle: (_isEditing["about_ar"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _about_arController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                const Gap(10),
                                _updateBtnsRow(
                                  "about_ar",
                                  _about_arController,
                                  context,
                                ),
                              ],
                            )
                          : Text(d.doctor!.about_ar),
                      trailing: IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            _isEditing["about_ar"] = !_isEditing["about_ar"]!;
                          });
                        },
                        icon: Icon(!_isEditing["about_ar"]!
                            ? Icons.edit
                            : Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
        );
      },
    );
  }
}
