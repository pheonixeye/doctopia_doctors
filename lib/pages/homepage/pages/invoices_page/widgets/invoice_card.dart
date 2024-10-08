// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:doctopia_doctors/extensions/invoice_translation_helpers_ext.dart';
import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/extensions/pdf_url_on_invoice_ext.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/pages/invoices_page/widgets/invoice_payment_details_dialog.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proklinik_models/models/detailed_invoice.dart';
import 'package:provider/provider.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.detailedInvoice});
  final DetailedInvoice detailedInvoice;

  @override
  Widget build(BuildContext context) {
    //todo: Build Ui
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card.outlined(
        elevation: 6,
        child: Consumer<PxLocale>(
          builder: (context, l, _) {
            return ExpansionTile(
              leading: FloatingActionButton.small(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => InvoicePaymentDetailsDialog(
                      invoice: detailedInvoice.invoice,
                    ),
                  );
                },
                heroTag: detailedInvoice.invoice.id,
                child: const Icon(Icons.monetization_on),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat(
                    'MM/yyyy',
                    l.locale.languageCode,
                  ).format(
                    DateTime(
                      detailedInvoice.invoice.year,
                      detailedInvoice.invoice.month,
                    ),
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                        "${context.loc.total} : ${detailedInvoice.invoice.total.toString().toArabicNumber(context)} ${context.loc.egp}"),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        //todo: Download pdf
                        final _url = detailedInvoice.invoice.pdfUrl;
                        html.window.open(_url, "Invoice", "_blank");
                      },
                      label: Text(context.loc.save),
                      icon: const Icon(Icons.download),
                    ),
                  ],
                ),
              ),
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${context.loc.numberOfPatients} : ${detailedInvoice.records.length.toString().toArabicNumber(context)}"),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${context.loc.isPaid} : ${detailedInvoice.invoice.paid.emoji()}"),
                        const SizedBox(height: 5),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                ...detailedInvoice.records.map((e) {
                  return ListTile(
                    leading: Text("(${detailedInvoice.records.indexOf(e) + 1})"
                        .toArabicNumber(context)),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: e.visit.user_name,
                          children: [
                            const TextSpan(text: " - "),
                            TextSpan(
                              text: DateFormat(
                                "dd/MM/yy",
                                l.locale.languageCode,
                              ).format(
                                DateTime.parse(e.visit.date_time),
                              ),
                            ),
                            const TextSpan(text: " - "),
                            if (e.visit.type != null &&
                                e.visit.type!.isNotEmpty)
                              TextSpan(
                                  text:
                                      "(${e.visit.type.ifVisitTypeTranslate(context)})")
                            else
                              TextSpan(text: '(${context.loc.unknown})'),
                          ],
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: l.isEnglish
                                  ? e.clinic.name_en
                                  : e.clinic.name_ar,
                              children: [
                                const TextSpan(text: "\n"),
                                TextSpan(
                                    text:
                                        "${context.loc.attended} : ${e.visit.attended.emoji()}"),
                                const TextSpan(text: "\n"),
                                TextSpan(
                                    text:
                                        "${context.loc.fees} : ${e.visit.attended ? "50".toArabicNumber(context) : "0".toArabicNumber(context)} ${context.loc.egp}"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Divider(),
                        const SizedBox(height: 5),
                        Text(
                            "${context.loc.visits} : ${detailedInvoice.invoice.amount.toString().toArabicNumber(context)} ${context.loc.egp}"),
                        Text(
                            "${context.loc.tax.toArabicNumber(context)} : ${detailedInvoice.invoice.tax.toString().toArabicNumber(context)} ${context.loc.egp}"),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "${context.loc.total} : ${detailedInvoice.invoice.total.toString().toArabicNumber(context)} ${context.loc.egp}"),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
