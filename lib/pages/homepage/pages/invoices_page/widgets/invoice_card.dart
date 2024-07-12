import 'package:doctopia_doctors/models/invoice/invoice.dart';
import 'package:flutter/material.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.invoice});
  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    //TODO: Build Ui
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card.outlined(
        elevation: 6,
        child: ExpansionTile(
          leading: FloatingActionButton.small(
            onPressed: null,
            heroTag: invoice.id,
            child: const Icon(Icons.inventory_outlined),
          ),
          title: Text("${invoice.month} - ${invoice.year}"),
        ),
      ),
    );
  }
}
