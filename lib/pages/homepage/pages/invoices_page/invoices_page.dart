import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctopia_doctors/functions/shell_function.dart';
import 'package:doctopia_doctors/pages/homepage/pages/bookings_page/logic/date_provider.dart';
import 'package:doctopia_doctors/pages/homepage/pages/invoices_page/widgets/invoice_card.dart';
import 'package:doctopia_doctors/providers/px_invoices.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return Consumer<PxInvoices>(
      builder: (context, v, _) {
        return ListView(
          cacheExtent: 3000,
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: Row(
                children: [
                  const Text('My Invoices'),
                  const Spacer(),
                  Text('${v.month} - ${v.year}'),
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
                          const SizedBox(
                            width: _textWidth,
                            child: Text("Year"),
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
                                        child: Text(e.toString()),
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
                          const SizedBox(
                            width: _textWidth,
                            child: Text("Month"),
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
                                        child: Text(e.value),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No Invoice For Selected Date.'),
                      ),
                    ),
                  ),
                ),
              )
            else
              InvoiceCard(invoice: v.invoice!),
          ],
        );
      },
    );
  }
}
