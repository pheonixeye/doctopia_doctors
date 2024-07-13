// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:doctopia_doctors/models/invoice/detailed_invoice.dart';

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
        child: ExpansionTile(
          leading: FloatingActionButton.small(
            onPressed: () {
              //TODO: go to payment page
            },
            heroTag: detailedInvoice.invoice.id,
            child: const Icon(Icons.monetization_on),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "${detailedInvoice.invoice.month} - ${detailedInvoice.invoice.year}"),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Total : ${detailedInvoice.invoice.total} EGP"),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    //todo: Download pdf
                    final _url = detailedInvoice.invoice.pdfUrl;
                    html.window.open(_url, "Invoice", "_blank");
                  },
                  label: const Text("Save Pdf"),
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
                    "Number Of Patients : ${detailedInvoice.records.length}"),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Is Paid : ${detailedInvoice.invoice.paid}"),
                    const SizedBox(height: 5),
                    const Divider(),
                  ],
                ),
              ),
            ),
            ...detailedInvoice.records.map((e) {
              return ListTile(
                leading: Text("(${detailedInvoice.records.indexOf(e) + 1})"),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      text: e.visit.user_name,
                      children: [
                        const TextSpan(text: " - "),
                        TextSpan(
                          text: DateFormat("dd/MM/yy")
                              .format(DateTime.parse(e.visit.date_time)),
                        ),
                        const TextSpan(text: " - "),
                        if (e.visit.type != null && e.visit.type!.isNotEmpty)
                          TextSpan(text: "(${e.visit.type})")
                        else
                          const TextSpan(text: "(Unknown)"),
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
                          text: e.clinic.name_en,
                          children: [
                            const TextSpan(text: " - "),
                            TextSpan(text: "Attended : ${e.visit.attended}"),
                            const TextSpan(text: " - "),
                            TextSpan(
                                text:
                                    "Fees : ${e.visit.attended ? "50 EGP" : "0 EGP"}"),
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
                    Text("Visits : ${detailedInvoice.invoice.amount} EGP"),
                    Text("Tax (14 %) : ${detailedInvoice.invoice.tax} EGP"),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Total : ${detailedInvoice.invoice.total} EGP"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
