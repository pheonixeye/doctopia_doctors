import 'dart:async' show FutureOr;

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/models/doctor/doctor.dart';
import 'package:doctopia_doctors/pages/register_page_basic/widgets/degree_selector.dart';
import 'package:doctopia_doctors/pages/register_page_basic/widgets/speciality_selector.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _listUpdates['titles_en'] = context.read<PxDoctor>().doctor.titles_en;
    _listUpdates['titles_ar'] = context.read<PxDoctor>().doctor.titles_ar;
  }

  Map<String, bool> isEditing =
      Doctor.scheme.map((key, value) => MapEntry(key, false));

  Map<String, List<String>> _listUpdates = {};

  //TODO: handle doctor info updates
  //HACK: may need another doctor model for editing ??

  @override
  Widget build(BuildContext context) {
    return Consumer<PxDoctor>(
      builder: (context, d, c) {
        if (!d.isLoggedIn) {
          return const Center(
            child: Text(
              'Not Logged In...',
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView(
          children: [
            const ListTile(
              leading: CircleAvatar(),
              title: Text('My Profile'),
            ),
            ...d.doctor.toJson().entries.map((e) {
              if (Doctor.editableFieldAttributes.contains(e.key)) {
                if (isEditing[e.key]!) {
                  return Card(
                    child: ListTile(
                      title: Text(e.key),
                      subtitle: Column(
                        children: [
                          TextFormField(
                            initialValue: e.value,
                            maxLines:
                                (e.key == 'about_en' || e.key == 'about_ar')
                                    ? 5
                                    : 1,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              context.read<PxDoctor>().setUpdate(e.key, value);
                            },
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  //COLLECT INFO
                                  //no need => SET DOCTOR

                                  //SEND UPDATE REQUEST
                                  await shellFunction(context,
                                      toExecute: () async {
                                    await context
                                        .read<PxDoctor>()
                                        .updateDoctor();
                                  });
                                  //no need => SEND FETCH UPDATED DOCTOR REQUEST

                                  setState(() {
                                    isEditing[e.key] = false;
                                  });
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Update'),
                              ),
                              const Gap(10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.read<PxDoctor>().revertUpdate(e.key);
                                  setState(() {
                                    isEditing[e.key] = false;
                                  });
                                },
                                icon: const Icon(Icons.close),
                                label: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Card(
                    child: ListTile(
                      title: Text(e.key),
                      subtitle: Text(e.value.toString()),
                      trailing: FloatingActionButton.small(
                        heroTag: e.key,
                        child: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            isEditing[e.key] = true;
                          });
                        },
                      ),
                    ),
                  );
                }
              } else if (Doctor.editableListAttributes.contains(e.key)) {
                if (isEditing[e.key]!) {
                  return Card(
                    child: ListTile(
                      title: Text(e.key),
                      subtitle: Column(
                        children: [
                          for (int i = 0;
                              i < (_listUpdates[e.key] as List<String>).length;
                              i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: TextFormField(
                                initialValue: _listUpdates[e.key]?[i],
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffix: SizedBox(
                                    height: 24,
                                    child: FloatingActionButton.small(
                                      heroTag: '${e.key}-$i-edit',
                                      onPressed: () {
                                        setState(() {
                                          _listUpdates[e.key]?.removeAt(i);
                                        });
                                        // d.removeIndexFromListInUpdate(e.key, i);
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  // d.addItemToListInUpdate(e.key, i, value);
                                  _listUpdates[e.key]?[i] = value.trim();
                                },
                              ),
                            ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  //done COLLECT INFO
                                  context
                                      .read<PxDoctor>()
                                      .setUpdate(e.key, _listUpdates[e.key]);
                                  //noneed SET DOCTOR
                                  //done SEND UPDATE REQUEST
                                  await shellFunction(context,
                                      toExecute: () async {
                                    await context
                                        .read<PxDoctor>()
                                        .updateDoctor();
                                  });
                                  //noneed SEND FETCH UPDATED DOCTOR REQUEST

                                  setState(() {
                                    isEditing[e.key] = false;
                                  });
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Update'),
                              ),
                              const Gap(10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isEditing[e.key] = false;
                                  });
                                },
                                icon: const Icon(Icons.close),
                                label: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: FloatingActionButton.small(
                        heroTag: e.key,
                        child: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _listUpdates[e.key]?.add(e.key);
                          });
                          // d.addItemToListInUpdate(e.key,
                          //     (d.update[e.key] as List<String>).length, '');
                        },
                      ),
                    ),
                  );
                } else {
                  return Card(
                    child: ListTile(
                      title: Text(e.key),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (String val in (e.value as List<String>))
                            Text(
                              '* $val',
                              textAlign: TextAlign.start,
                            )
                        ],
                      ),
                      trailing: FloatingActionButton.small(
                        heroTag: e.key,
                        child: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            isEditing[e.key] = true;
                          });
                        },
                      ),
                    ),
                  );
                }
              } else if (e.key == 'password') {
                return ElevatedButton.icon(
                  onPressed: () async {},
                  icon: const Icon(Icons.password),
                  label: const Text('Change Password'),
                );
              } else {
                return const SizedBox();
              }
            }).toList(),
          ],
        );
      },
    );
  }
}

Widget specialityAndDegree(String key) {
  if (Doctor.editableDropdownAttributes.contains(key)) {
    if (key == 'speciality_en') {
      return Card(
        child: Row(
          children: [
            const Expanded(
              child: SpecialitySelector(),
            ),
            FloatingActionButton.small(
              heroTag: 'update-speciality',
              child: const Icon(Icons.save),
              onPressed: () {},
            ),
            const Gap(20),
          ],
        ),
      );
    }
    if (key == 'degree_en') {
      return Card(
        child: Row(
          children: [
            const Expanded(
              child: DegreeSelector(),
            ),
            FloatingActionButton.small(
              heroTag: 'update-degree',
              child: const Icon(Icons.save),
              onPressed: () {},
            ),
            const Gap(20),
          ],
        ),
      );
    }
    return const SizedBox();
  }
  return const SizedBox();
}

Widget isPublished(String key, bool value) {
  if (key == 'published') {
    return Card(
      child: ListTile(
        title: Text(key),
        trailing: FloatingActionButton(
          heroTag: 'is-published',
          onPressed: null,
          child: (value) ? const Icon(Icons.check) : const Icon(Icons.close),
        ),
      ),
    );
  }
  return const SizedBox();
}
