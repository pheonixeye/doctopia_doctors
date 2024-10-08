import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/widgets/clinic_visits_tile.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/logic/date_provider.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> with AfterLayoutMixin {
  final _dateProvider = WidgetsDateProvider();
  static const double _textWidth = 50;
  static const double _daysWidth = 90;
  static const double _monthsWidth = 150;
  static const double _yearsWidth = 120;
  late final ScrollController _yearsController;
  late final ScrollController _monthsController;
  late final ScrollController _daysController;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final cv = context.read<PxClinicVisits>();

    _animateToIndex(_monthsController, cv.month, _monthsWidth);
    _animateToIndex(_daysController, cv.day, _daysWidth);
  }

  void _animateToIndex(ScrollController _controller, int index, double _width) {
    _controller.animateTo(
      (index - 1) * _width,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    _yearsController = ScrollController();
    _monthsController = ScrollController();
    _daysController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _yearsController.dispose();
    _monthsController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxClinicVisits, PxLocale>(
      builder: (context, v, l, _) {
        return ListView(
          cacheExtent: 3000,
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: Row(
                children: [
                  Text(context.loc.myBookings),
                  const Spacer(),
                  v.day == 0
                      ? Text(
                          DateFormat(
                            'MM/yyyy',
                            l.locale.languageCode,
                          ).format(
                            DateTime(v.year, v.month),
                          ),
                        )
                      : Text(
                          DateFormat(
                            'dd/MM/yyyy',
                            l.locale.languageCode,
                          ).format(
                            DateTime(v.year, v.month, v.day),
                          ),
                        ),
                  const Spacer(),
                ],
              ),
              trailing: FloatingActionButton.small(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                tooltip: context.loc.todayBookings,
                heroTag: 'today-bookings',
                onPressed: () async {
                  final _today = DateTime.now();
                  await shellFunction(
                    context,
                    toExecute: () async {
                      v.setDate(
                        d: _today.day,
                        m: _today.month,
                        y: _today.year,
                      );
                    },
                  );
                },
                child: const Icon(Icons.today),
              ),
            ),
            Card(
              //extract this into another widget
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
                          SizedBox(
                            width: _textWidth,
                            child: Text(context.loc.year),
                          ),
                          const Gap(10),
                          Expanded(
                            child: ListView(
                              controller: _yearsController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.years.map((e) {
                                  bool isSelected = e == v.year;
                                  return SizedBox(
                                    width: _yearsWidth,
                                    child: Card(
                                      elevation: isSelected ? 0 : 10,
                                      child: RadioMenuButton<int>(
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
                                        child: Text(e
                                            .toString()
                                            .toArabicNumber(context)),
                                      ),
                                    ),
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
                          SizedBox(
                            width: _textWidth,
                            child: Text(context.loc.month),
                          ),
                          const Gap(10),
                          Expanded(
                            child: ListView(
                              controller: _monthsController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.months.entries.map((e) {
                                  bool isSelected = e.key == v.month;
                                  return SizedBox(
                                    width: _monthsWidth,
                                    child: Card(
                                      elevation: isSelected ? 0 : 10,
                                      child: RadioMenuButton<int>(
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
                                        child: Text(
                                            e.value.ifMonthTranslate(context)),
                                      ),
                                    ),
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
                          // const Gap(10),
                          Tooltip(
                            message: context.loc.allMonthBookings,
                            child: SizedBox(
                              width: _textWidth,
                              child: Card.outlined(
                                elevation: v.day == 0 ? 0 : 6,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text.rich(
                                      TextSpan(
                                        text: context.loc.day,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            await shellFunction(
                                              context,
                                              toExecute: () async {
                                                await v.setDate(d: 0);
                                              },
                                            );
                                          },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                            child: ListView(
                              controller: _daysController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.daysPerMonth(v.month).map((e) {
                                  bool isSelected = e == v.day;

                                  return SizedBox(
                                    width: _daysWidth,
                                    child: Card(
                                      elevation: isSelected ? 0 : 10,
                                      child: RadioMenuButton<int>(
                                        value: e,
                                        groupValue: v.day,
                                        onChanged: (value) async {
                                          await shellFunction(context,
                                              toExecute: () async {
                                            await v.setDate(d: value);
                                          });
                                        },
                                        child: Text(e
                                            .toString()
                                            .toArabicNumber(context)),
                                      ),
                                    ),
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
            Builder(
              builder: (context) {
                while (v.data.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Text(context.loc.noVisitsInSelectedDate),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: v.data.length,
                  itemBuilder: (context, index) {
                    return ClinicVisitsTile(
                      index: index,
                      visit: v.data[index],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
