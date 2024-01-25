import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/logic/_px_clinic_visits.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/logic/date_provider.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/widgets/clinic_visits_tile.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> with AfterLayoutMixin {
  final _dateProvider = WidgetsDateProvider();
  static const double _textWidth = 50;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxClinicVisits>().fetchClinicVisits();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxClinicVisits>(
      builder: (context, v, c) {
        return ListView(
          cacheExtent: 3000,
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: Row(
                children: [
                  const Text('My Bookings'),
                  const Spacer(),
                  Text('${v.day} - ${v.month} - ${v.year}'),
                  const Spacer(),
                ],
              ),
            ),
            Card(
              //TODO: extract this into another widget
              //use provider for date instead of setstate
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: _textWidth,
                      child: Row(
                        children: [
                          const Gap(10),
                          const SizedBox(
                            width: _textWidth,
                            child: Text("Year"),
                          ),
                          const Gap(10),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.years.map((e) {
                                  return RadioMenuButton<int>(
                                    value: e,
                                    groupValue: v.year,
                                    onChanged: (value) async {
                                      await shellFunction(
                                        context,
                                        toExecute: () async {
                                          await v.setDate(y: value);
                                        },
                                      );
                                    },
                                    child: Text(e.toString()),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _textWidth,
                      child: Row(
                        children: [
                          const Gap(10),
                          const SizedBox(
                            width: _textWidth,
                            child: Text("Month"),
                          ),
                          const Gap(10),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.months.entries.map((e) {
                                  return RadioMenuButton<int>(
                                    value: e.key,
                                    groupValue: v.month,
                                    onChanged: (value) async {
                                      await shellFunction(
                                        context,
                                        toExecute: () async {
                                          await v.setDate(m: value);
                                        },
                                      );
                                    },
                                    child: Text(e.value),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _textWidth,
                      child: Row(
                        children: [
                          const Gap(10),
                          const SizedBox(
                            width: _textWidth,
                            child: Text("Day"),
                          ),
                          const Gap(10),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.daysPerMonth(v.month).map((e) {
                                  return RadioMenuButton<int>(
                                    value: e,
                                    groupValue: v.day,
                                    onChanged: (value) async {
                                      await shellFunction(context,
                                          toExecute: () async {
                                        await v.setDate(d: value);
                                      });
                                    },
                                    child: Text(e.toString()),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Consumer<PxClinics>(
              builder: (context, c, _) {
                //extract this into another widget
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: c.clinics.isEmpty
                        ? const Center(
                            child: Text(
                              'No Clinics Yet',
                            ),
                          )
                        : Column(
                            children: [
                              ...c.clinics.map((e) {
                                return ClinicVisitsTile(
                                  clinicData: e,
                                );
                              }).toList(),
                            ],
                          ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
