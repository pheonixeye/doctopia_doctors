import 'package:doctopia_doctors/models/city.dart';
import 'package:doctopia_doctors/models/clinic/clinic.dart';
import 'package:doctopia_doctors/models/governorate.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateClinicPage extends StatefulWidget {
  const CreateClinicPage({super.key});

  @override
  State<CreateClinicPage> createState() => _CreateClinicPageState();
}

class _CreateClinicPageState extends State<CreateClinicPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Clinic'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ...Clinic.editableStrings.map((e) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: e,
                      border: const OutlineInputBorder(),
                      suffix: const SizedBox(
                        height: 24,
                      ),
                    ),
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
                              onChanged: (val) {
                                g.selectGov(val);
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
                              onChanged: (val) {
                                gov.selectCity(val);
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
                        subtitle: DropdownButtonFormField<int>(
                          items: [0, 1].map(
                            (e) {
                              return DropdownMenuItem<int>(
                                value: e,
                                alignment: Alignment.center,
                                child: Text(
                                  e == 0 ? "FiFo" : "By Time",
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {},
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
                    //TODO: validate fields
                    //TODO: send create clinic request
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
      ),
    );
  }
}
