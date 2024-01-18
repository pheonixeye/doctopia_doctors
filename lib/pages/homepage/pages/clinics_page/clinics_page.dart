import 'package:flutter/material.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: const CircleAvatar(),
          title: Text('My Clinics'),
        ),
      ],
    );
  }
}
