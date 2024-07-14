import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

///Shell function encapsulating loading & error handling logic in the UI
Future<void> shellFunction(
  BuildContext context, {
  required Function toExecute,
  String sucessMsg = "Success...",
  Function? onCatch,
  Duration duration = const Duration(seconds: 10),
}) async {
  try {
    await EasyLoading.show(status: "LOADING...");
    await toExecute();
    await EasyLoading.dismiss();
    if (context.mounted) {
      showInfoSnackbar(context, sucessMsg);
    }
  } catch (e) {
    await EasyLoading.dismiss();
    if (context.mounted) {
      showInfoSnackbar(
        context,
        e.toString(),
        Colors.red,
        duration,
      );
      if (onCatch != null) {
        onCatch();
      }
    }
  }
}
