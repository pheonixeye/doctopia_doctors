// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/models/degree/degree.dart';
import 'package:doctopia_doctors/models/doctor/doctor.dart';
import 'package:doctopia_doctors/models/speciality.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
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
      return "Empty Inputs Are Not Allowed";
    }
    return null;
  }

  Future<void> _UpdateDoctorField(String key, dynamic value) async {
    final d = context.read<PxDoctor>();
    d.setUpdate(key, value);
    await d.updateDoctor();
  }

  void _RevertUpdate(String key) {
    final d = context.read<PxDoctor>();
    d.revertUpdate(key);
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
              try {
                await EasyLoading.show(status: "Loading...");
                if (field == "synd_id") {
                  await _UpdateDoctorField(
                      field, int.parse(controller.text.trim()));
                } else {
                  await _UpdateDoctorField(field, controller.text.trim());
                }
                await EasyLoading.showSuccess("Success...");
                setState(() {
                  _isEditing[field] = false;
                });
              } catch (e) {
                await EasyLoading.dismiss();

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
        final isDoctorNull = d.doctor == null;

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
                      title: const Text("English Name"),
                      subtitle: (isDoctorNull || _isEditing["name_en"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _name_enController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                if (!isDoctorNull)
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
                          if (isDoctorNull) {
                            return;
                          }
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
                      title: const Text("Arabic Name"),
                      subtitle: (isDoctorNull || _isEditing["name_ar"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _name_arController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                if (!isDoctorNull)
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
                          if (isDoctorNull) {
                            return;
                          }
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
                      title: const Text("Speciality"),
                      trailing: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.close,
                          color: Colors.transparent,
                        ),
                      ),
                      subtitle: (isDoctorNull ||
                              _isEditing["specialty_en"] == true)
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
                                        return "Invalid Input, Kindly Select Speciality";
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
                      title: const Text("Medical Degree"),
                      trailing: (_isEditing["degree_en"] == false)
                          ? IconButton.outlined(
                              onPressed: () {
                                setState(() {
                                  _isEditing["degree_en"] == true;
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            )
                          : isDoctorNull
                              ? const IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.transparent,
                                  ),
                                )
                              : const SizedBox(),
                      //TODO: refactor whole page
                      //TODO: set correct conditioning
                      subtitle: (isDoctorNull ||
                              _isEditing["degree_en"] == true)
                          ? DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<Degree>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return "Invalid Input, Kindly Select Degree";
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
                                  if (!isDoctorNull && value != null) {
                                    try {
                                      await EasyLoading.show(
                                          status: "Loading...");
                                      await _UpdateDoctorField(
                                          "degree_en", value.en);
                                      await _UpdateDoctorField(
                                          "degree_ar", value.ar);
                                      await EasyLoading.showSuccess(
                                          "Success...");
                                    } catch (e) {
                                      await EasyLoading.dismiss();
                                      await EasyLoading.showError(e.toString());
                                      setState(() {
                                        _isEditing["degree_en"] == false;
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
                      title: const Text("English Title"),
                      subtitle: (isDoctorNull || _isEditing["title_en"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                  controller: _title_enController,
                                ),
                                if (!isDoctorNull)
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
                          if (isDoctorNull) {
                            return;
                          }
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
                      title: const Text("Arabic Title"),
                      subtitle: (isDoctorNull || _isEditing["title_ar"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _title_arController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                if (!isDoctorNull)
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
                          if (isDoctorNull) {
                            return;
                          }
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
                      title: const Text("English About"),
                      subtitle: (isDoctorNull || _isEditing["about_en"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _about_enController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                if (!isDoctorNull)
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
                          if (isDoctorNull) {
                            return;
                          }
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
                      title: const Text("Arabic About"),
                      subtitle: (isDoctorNull || _isEditing["about_ar"] == true)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _about_arController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: _validator,
                                ),
                                const Gap(10),
                                if (!isDoctorNull)
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
                          if (isDoctorNull) {
                            return;
                          }
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
              if (isDoctorNull)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
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
                          await EasyLoading.show(status: "Loading...");
                          await d.createDoctor();
                          await EasyLoading.showSuccess("Success...");
                        } catch (e) {
                          d.nullifyDoctor();
                          await EasyLoading.dismiss();
                          if (kDebugMode) {
                            print(e);
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
                        }
                      }
                    },
                    label: const Text("Save"),
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
