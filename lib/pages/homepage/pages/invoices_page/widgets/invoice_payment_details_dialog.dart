import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:proklinik_models/models/invoice.dart';

class InvoicePaymentDetailsDialog extends StatelessWidget {
  const InvoicePaymentDetailsDialog({
    super.key,
    required this.invoice,
  });
  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(context.loc.paymentDetails),
          const Spacer(),
          IconButton.outlined(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const FloatingActionButton.small(
                  heroTag: 'service-no',
                  onPressed: null,
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.paymentServiceNumber),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText("767".toArabicNumber(context)),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const FloatingActionButton.small(
                  heroTag: 'ref-no',
                  onPressed: null,
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.paymentReferenceNumber),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(invoice.payment_reference),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const FloatingActionButton.small(
                  heroTag: 'pay-link',
                  onPressed: null,
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.paymentLink),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText.rich(
                    TextSpan(
                      text: invoice.payment_link,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          html.window.open(
                            invoice.payment_link,
                            "Payment Portal",
                            "_blank",
                          );
                        },
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
