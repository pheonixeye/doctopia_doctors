// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:doctopia_doctors/providers/px_publish_request.dart';
import 'package:doctopia_doctors/providers/px_reviews.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: (login process):
//step 1: fetch Doctor Model<done>
//step 1*: subscribe to firebase doc_id topic (Notifications)<done>
//step 2: fetch Doctor Documents<done>
//step 3: fetch Doctor Clinics<done>
//step 3*: fetch publish request status
//step 4: fetch Doctor Visits<done>
//step 5: fetch Doctor Invoices
//step 6: fetch Doctor Articles
//step 7: homepage feed
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
        FirebaseMessaging.instance.subscribeToTopic(doc.id!),
        context.read<PxDocuments>().initDocuments(doc.id!),
        context.read<PxClinics>().fetchClinics(doc.id!),
        context.read<PxPublishRequest>().fetchPublishRequest(),
        context.read<PxReviews>().fetchReviews(doc.id!),
      ]);
    }
  } catch (e) {
    rethrow;
  }
}
