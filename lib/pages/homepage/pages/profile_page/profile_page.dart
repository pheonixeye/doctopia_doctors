// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/pages/homepage/pages/profile_page/widgets/doctor_profile_create.dart';
import 'package:doctopia_doctors/pages/homepage/pages/profile_page/widgets/doctor_profile_edit.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //todo: update ui
    //todo: update logic
    //todo: extract in a separate widget
    return Consumer<PxDoctor>(
      builder: (context, d, _) {
        while (d.doctor == null) {
          return const DoctorProfileCreate();
        }
        return DoctorProfileEdit();
      },
    );
  }
}
