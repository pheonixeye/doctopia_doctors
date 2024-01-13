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

class _ProfilePageState extends State<ProfilePage> {
  Map<String, bool> isEditing =
      Doctor.scheme.map((key, value) => MapEntry(key, false));

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
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  //TODO: COLLECT INFO
                                  //TODO: SET DOCTOR
                                  //TODO: SEND UPDATE REQUEST
                                  //TODO: SEND FETCH UPDATED DOCTOR REQUEST

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
              } else if (Doctor.editableDropdownAttributes.contains(e.key)) {
                if (e.key == 'speciality_en') {
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
                if (e.key == 'degree_en') {
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
              } else if (Doctor.editableListAttributes.contains(e.key)) {
                if (isEditing[e.key]!) {
                  return Card(
                    child: ListTile(
                      title: Text(e.key),
                      subtitle: Column(
                        children: [
                          ...(e.value as List).map((x) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: TextFormField(
                                initialValue: x,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffix: SizedBox(
                                    height: 24,
                                    child: FloatingActionButton.small(
                                      heroTag: '$x-edit',
                                      onPressed: () {
                                        setState(() {
                                          (e.value as List).remove(x);
                                        });
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  //TODO: COLLECT INFO
                                  //TODO: SET DOCTOR
                                  //TODO: SEND UPDATE REQUEST
                                  //TODO: SEND FETCH UPDATED DOCTOR REQUEST

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
                            (e.value as List).add('');
                          });
                        },
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
              } else if (e.key == 'password') {
                return ElevatedButton.icon(
                  onPressed: () async {},
                  icon: const Icon(Icons.password),
                  label: const Text('Change Password'),
                );
              } else if (e.key == 'published') {
                return Card(
                  child: ListTile(
                    title: Text(e.key),
                    trailing: FloatingActionButton(
                      heroTag: 'is-published',
                      onPressed: null,
                      child: (e.value as bool)
                          ? const Icon(Icons.check)
                          : const Icon(Icons.close),
                    ),
                  ),
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
