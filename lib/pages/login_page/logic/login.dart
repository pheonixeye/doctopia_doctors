// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> loginLogic({
  required BuildContext context,
  required int synd_id,
  required String password,
}) async {
  try {
    final doc = await context.read<PxDoctor>().fetchDoctor(
          synd_id: synd_id,
          password: password,
          errorMsg: 'Wrong id / password combination.',
        );
    if (context.mounted) {
      await Future.wait([
        context.read<PxDocuments>().initDocuments(doc.id!),
        context.read<PxClinics>().fetchClinics(doc.id!),
      ]);
    }
  } catch (e) {
    rethrow;
  }
}
