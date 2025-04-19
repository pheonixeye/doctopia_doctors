// ignore: avoid_web_libraries_in_flutter
import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/constants/static_app_constants.dart';
import 'package:doctopia_doctors/models/invoice_response_model/invoice.dart';
import 'package:doctopia_doctors/providers/px_app_constants.dart';
// import 'package:web/web.dart' as html;

import 'package:doctopia_doctors/extensions/number_translator.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/pages/homepage/pages/invoices_page/widgets/invoice_payment_details_dialog.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.invoice});
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    //todo: Build Ui
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card.outlined(
        elevation: 6,
        child: Consumer2<PxLocale, PxAppConstants>(
          builder: (context, l, a, _) {
            while (a.model == null) {
              return const Padding(
                padding: EdgeInsets.only(
                  top: StaticAppConstants.midComponentTopPadding,
                ),
                child: CentralLoading(),
              );
            }
            return ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat(
                          'MM / yyyy',
                          l.locale.languageCode,
                        ).format(
                          DateTime(
                            invoice.year,
                            invoice.month,
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton.small(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => InvoicePaymentDetailsDialog(
                            invoice: invoice,
                          ),
                        );
                      },
                      heroTag: invoice.id,
                      child: const Icon(Icons.monetization_on),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                        "${context.loc.total} : ${invoice.total.toString().toArabicNumber(context)} ${context.loc.egp}"),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        //TODO: Download pdf

                        // final _url = invoice.invoice.pdfUrl;
                        // html.window.open(_url, "Invoice", "_blank");
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
                    child: Text(context.loc.invoiceStatus),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(
                      builder: (context) {
                        final _invoiceStatus =
                            a.model!.invoice_status.firstWhere(
                          (status) => status.id == invoice.invoice_status.id,
                        );
                        return Text(
                            "${context.loc.isPaid} : ${l.isEnglish ? _invoiceStatus.name_en : _invoiceStatus.name_ar}");
                      },
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
