import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit_filter.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/logic/date_provider.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class VisitsFilterSection extends StatefulWidget {
  const VisitsFilterSection({super.key});

  @override
  State<VisitsFilterSection> createState() => _VisitsFilterSectionState();
}

class _VisitsFilterSectionState extends State<VisitsFilterSection>
    with AfterLayoutMixin {
  final _dateProvider = WidgetsDateProvider();

  static const double _textWidth = 50;
  static const double _daysWidth = 90;
  static const double _monthsWidth = 150;
  static const double _yearsWidth = 120;

  late final ScrollController _yearsController;
  late final ScrollController _monthsController;
  late final ScrollController _daysController;

  late final ScrollController _visitsScrollController;

  late final PxClinicVisits cv;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _animateOnFilterChange();
  }

  Future<void> _animateToIndex(
      ScrollController _controller, int index, double _width) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _controller.animateTo(
      (index - 1) * _width,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _animateOnFilterChange() {
    _animateToIndex(_yearsController, cv.year, _yearsWidth);
    if (cv.month != null) {
      _animateToIndex(_monthsController, cv.month!, _monthsWidth);
    }
    if (cv.day != null) {
      _animateToIndex(_daysController, cv.day!, _daysWidth);
    }
  }

  @override
  void initState() {
    cv = context.read<PxClinicVisits>();
    _yearsController = ScrollController();
    _monthsController = ScrollController();
    _daysController = ScrollController();
    _visitsScrollController = ScrollController();
    _visitsScrollController.addListener(_visitsScrollListenter);
    super.initState();
  }

  Future<void> _visitsScrollListenter() async {
    final _toCall = _visitsScrollController.position.pixels ==
        _visitsScrollController.position.maxScrollExtent;
    if (_toCall) {
      if (cv.isLoading) {
        return;
      }
      await cv.fetchMoreVisits();
    }
  }

  @override
  void dispose() {
    _yearsController.dispose();
    _monthsController.dispose();
    _daysController.dispose();
    _visitsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxClinicVisits>(
      builder: (context, l, v, _) {
        return Card.outlined(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(),
          ),
          //extract this into another widget
          //use provider for date instead of setstate
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.all(0),
            leading: FloatingActionButton.small(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              tooltip: context.loc.todayBookings,
              heroTag: 'today-bookings',
              onPressed: () async {
                await shellFunction(
                  context,
                  toExecute: () async {
                    await v.selectFilter(VisitFilter.year_month_day);
                  },
                );
                _animateOnFilterChange();
              },
              child: const Icon(Icons.today),
            ),
            initiallyExpanded: true,
            title: Text(context.loc.visitsFilter),
            children: [
              Row(
                children: [
                  ...VisitFilter.values.map((filter) {
                    return Expanded(
                      child: Card.outlined(
                        elevation: filter == v.filter ? 0 : 6,
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          title: Text(l.isEnglish ? filter.en : filter.ar),
                          selected: filter == v.filter,
                          value: filter,
                          groupValue: v.filter,
                          onChanged: (value) async {
                            if (value != null) {
                              await shellFunction(
                                context,
                                toExecute: () async {
                                  await v.selectFilter(value);
                                },
                              );
                              _animateOnFilterChange();
                            }
                          },
                        ),
                      ),
                    );
                  })
                ],
              ),
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
                                elevation: isSelected ? 0 : 6,
                                child: RadioListTile<int>(
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  selected: isSelected,
                                  title: Text(
                                      e.toString().toArabicNumber(context)),
                                  value: e,
                                  groupValue: v.year,
                                  onChanged: (value) async {
                                    if (value == null) {
                                      return;
                                    }
                                    await shellFunction(
                                      context,
                                      toExecute: () async {
                                        await v.setDate(
                                          d: v.day,
                                          m: v.month,
                                          y: value,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (v.filter == VisitFilter.year_month_day ||
                  v.filter == VisitFilter.year_month)
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
                                  elevation: isSelected ? 0 : 6,
                                  child: RadioListTile<int>(
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                    selected: isSelected,
                                    value: e.key,
                                    groupValue: v.month,
                                    onChanged: (value) async {
                                      if (value == null) {
                                        return;
                                      }
                                      await shellFunction(
                                        context,
                                        toExecute: () async {
                                          await v.setDate(
                                            d: v.day,
                                            m: value,
                                            y: v.year,
                                          );
                                        },
                                      );
                                    },
                                    title:
                                        Text(e.value.ifMonthTranslate(context)),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (v.filter == VisitFilter.year_month_day)
                SizedBox(
                  height: _textWidth,
                  child: Row(
                    children: [
                      Tooltip(
                        message: context.loc.allMonthBookings,
                        child: SizedBox(
                          width: _textWidth,
                          child: Card.outlined(
                            elevation: v.day == null ? 0 : 6,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                            await v.setDate(
                                              d: null,
                                              m: v.month,
                                              y: v.year,
                                            );
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
                                  elevation: isSelected ? 0 : 6,
                                  child: RadioListTile<int>(
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                    selected: isSelected,
                                    value: e,
                                    groupValue: v.day,
                                    onChanged: (value) async {
                                      if (value == null) {
                                        return;
                                      }
                                      await shellFunction(context,
                                          toExecute: () async {
                                        await v.setDate(
                                          d: value,
                                          m: v.month,
                                          y: v.year,
                                        );
                                      });
                                    },
                                    title: Text(
                                        e.toString().toArabicNumber(context)),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
