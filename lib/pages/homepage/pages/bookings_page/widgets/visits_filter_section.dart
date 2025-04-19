import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/visit_response_model/visit_filter.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/logic/date_provider.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

  late final ItemScrollController _yearsController;
  late final ItemScrollController _monthsController;
  late final ItemScrollController _daysController;

  late final PxClinicVisits cv;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await _animateFilter();
  }

  Future<void> _animateToCertainIndex(
    ItemScrollController controller,
    int index,
  ) async {
    await controller.scrollTo(
      index: index - 1,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _animateFilter() async {
    await Future.delayed(const Duration(milliseconds: 100));
    await Future.wait([
      _animateToCertainIndex(_yearsController, cv.year),
      if (cv.month != null)
        _animateToCertainIndex(_monthsController, cv.month!),
      if (cv.day != null) _animateToCertainIndex(_daysController, cv.day!),
    ]);
  }

  @override
  void initState() {
    cv = context.read<PxClinicVisits>();
    _yearsController = ItemScrollController();
    _monthsController = ItemScrollController();
    _daysController = ItemScrollController();
    super.initState();
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
                    final _today = DateTime.now();
                    final _obligatoryFilter = VisitFilter.year_month_day;
                    await Future.wait([
                      if (v.filter != _obligatoryFilter)
                        v.selectFilter(_obligatoryFilter),
                      v.setDate(
                        d: _today.day,
                        m: _today.month,
                        y: _today.year,
                      ),
                      _animateFilter(),
                    ]);
                  },
                );
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
                        child: RadioListTile<VisitFilter>(
                          key: ValueKey(filter),
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
                                  await Future.wait([
                                    _animateFilter(),
                                    v.selectFilter(value),
                                  ]);
                                },
                              );
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
                      child: ScrollablePositionedList.builder(
                        itemBuilder: (context, index) {
                          final e = _dateProvider.years[index];
                          bool isSelected = e == v.year;
                          return SizedBox(
                            width: _yearsWidth,
                            child: Card(
                              elevation: isSelected ? 0 : 6,
                              child: RadioListTile<int>(
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                selected: isSelected,
                                title:
                                    Text(e.toString().toArabicNumber(context)),
                                value: e,
                                groupValue: v.year,
                                onChanged: (value) async {
                                  if (value == null) {
                                    return;
                                  }
                                  await shellFunction(
                                    context,
                                    toExecute: () async {
                                      await Future.wait([
                                        v.setDate(
                                          d: v.day,
                                          m: v.month,
                                          y: value,
                                        ),
                                        _animateFilter(),
                                      ]);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        itemCount: _dateProvider.years.length,
                        itemScrollController: _yearsController,
                        scrollDirection: Axis.horizontal,
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
                        child: ScrollablePositionedList.builder(
                          itemCount: _dateProvider.months.entries.length,
                          itemScrollController: _monthsController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final e =
                                _dateProvider.months.entries.toList()[index];
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
                                        await Future.wait([
                                          v.setDate(
                                            d: v.day,
                                            m: value,
                                            y: v.year,
                                          ),
                                          _animateFilter(),
                                        ]);
                                      },
                                    );
                                  },
                                  title:
                                      Text(e.value.ifMonthTranslate(context)),
                                ),
                              ),
                            );
                          },
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
                      const Gap(10),
                      SizedBox(
                        width: _textWidth,
                        child: Text(context.loc.day),
                      ),
                      const Gap(10),
                      Expanded(
                        child: ScrollablePositionedList.builder(
                          itemScrollController: _daysController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _dateProvider.daysPerMonth(v.month).length,
                          itemBuilder: (context, index) {
                            final e =
                                _dateProvider.daysPerMonth(v.month)[index];
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
                                      await Future.wait([
                                        v.setDate(
                                          d: value,
                                          m: v.month,
                                          y: v.year,
                                        ),
                                        _animateFilter(),
                                      ]);
                                    });
                                  },
                                  title: Text(
                                      e.toString().toArabicNumber(context)),
                                ),
                              ),
                            );
                          },
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
