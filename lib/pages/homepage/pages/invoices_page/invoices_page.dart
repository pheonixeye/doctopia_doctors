import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/logic/date_provider.dart';
import 'package:doctopia_doctors/pages/homepage/pages/invoices_page/widgets/invoice_card.dart';
import 'package:doctopia_doctors/providers/px_invoices.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> with AfterLayoutMixin {
  final _dateProvider = WidgetsDateProvider();
  static const double _textWidth = 50;
  static const double _monthsWidth = 150;
  static const double _yearsWidth = 120;
  late final ScrollController _yearsController;
  late final ScrollController _monthsController;

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

    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final cv = context.read<PxInvoices>();
    _animateToIndex(_yearsController, cv.year, _yearsWidth);
    _animateToIndex(_monthsController, cv.month, _monthsWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxInvoices, PxLocale>(
      builder: (context, v, l, _) {
        return ListView(
          cacheExtent: 3000,
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: Row(
                children: [
                  Text(context.loc.invoices),
                  const Spacer(),
                  Text(
                    DateFormat(
                      'MM/yyyy',
                      l.locale.languageCode,
                    ).format(
                      DateTime(v.year, v.month),
                    ),
                  ),
                  const Spacer(),
                ],
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
                  ],
                ),
              ),
            ),
            const Divider(),
            if (v.invoice == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.loc.noInvoicesForDate),
                      ),
                    ),
                  ),
                ),
              )
            else
              InvoiceCard(detailedInvoice: v.invoice!),
          ],
        );
      },
    );
  }
}
