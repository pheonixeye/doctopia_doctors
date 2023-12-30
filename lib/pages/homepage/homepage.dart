import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/city.dart';
import 'package:doctopia_doctors/models/governorate.dart';
import 'package:doctopia_doctors/models/speciality.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Governorate? _gov;
  City? _city;
  Speciality? _spec;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(context.t.doctopia),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.t.hi,
            ),
            Card(
              elevation: 10,
              child: Consumer2<PxGov, PxLocale>(
                builder: (context, g, l, c) {
                  final isEnglish = l.locale == const Locale('en');
                  while (g.govs == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DropdownButton<Governorate>(
                    hint: const Center(
                      child: Text('Select Governorate...'),
                    ),
                    items: g.govs?.map((e) {
                      return DropdownMenuItem<Governorate>(
                        alignment: Alignment.center,
                        value: e,
                        child: Text(isEnglish
                            ? e.governorate_name_en
                            : e.governorate_name_ar),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    value: _gov,
                    onChanged: (val) {
                      setState(() {
                        _gov = val;
                        _city = null;
                      });
                    },
                  );
                },
              ),
            ),
            const Gap(20),
            Card(
              elevation: 10,
              child: Consumer<PxLocale>(
                builder: (context, l, c) {
                  final isEnglish = l.locale == const Locale('en');
                  while (_gov == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DropdownButton<City>(
                    hint: const Center(
                      child: Text('Select City...'),
                    ),
                    items: _gov == null
                        ? []
                        : _gov?.cities.map((e) {
                            return DropdownMenuItem<City>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(
                                  isEnglish ? e.city_name_en : e.city_name_ar),
                            );
                          }).toList(),
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    value: _city,
                    onChanged: (val) {
                      setState(() {
                        _city = val;
                      });
                    },
                  );
                },
              ),
            ),
            const Gap(20),
            Card(
              elevation: 10,
              child: Consumer<PxLocale>(
                builder: (context, l, c) {
                  final isEnglish = l.locale == const Locale('en');

                  return DropdownButton<Speciality>(
                    hint: const Center(
                      child: Text('Select Speciality...'),
                    ),
                    items: Speciality.list.map((e) {
                      return DropdownMenuItem<Speciality>(
                        alignment: Alignment.center,
                        value: e,
                        child: Text(isEnglish ? e.en : e.ar),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    value: _spec,
                    onChanged: (val) {
                      setState(() {
                        _spec = val;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<PxLocale>().changeLocale();
            },
            tooltip: 'Locale',
            heroTag: 'locale',
            child: const Icon(Icons.language),
          ),
          const Gap(20),
          FloatingActionButton(
            onPressed: () {
              context.read<PxTheme>().setThemeMode();
            },
            tooltip: 'Theme',
            heroTag: 'theme',
            child: const Icon(Icons.theater_comedy),
          ),
        ],
      ),
    );
  }
}
