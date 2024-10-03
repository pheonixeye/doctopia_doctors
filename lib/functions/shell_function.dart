import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/components/main_snackbar.dart';
import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:flutter/material.dart';

///Shell function encapsulating loading & error handling logic in the UI
Future<void> shellFunction(
  BuildContext context, {
  required Function toExecute,
  String sucessMsg = '',
  Function? onCatch,
  Duration duration = const Duration(seconds: 10),
}) async {
  late BuildContext _loadingContext;
  try {
    if (sucessMsg.isEmpty) {
      sucessMsg = context.loc.success;
    }
    if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) {
            _loadingContext = context;
            return const CentralLoading();
          });
    }
    await toExecute();
    // await EasyLoading.dismiss();
    if (_loadingContext.mounted) {
      Navigator.pop(_loadingContext);
    }
    if (context.mounted) {
      showInfoSnackbar(context, sucessMsg);
    }
  } catch (e) {
    // await EasyLoading.dismiss();
    if (_loadingContext.mounted) {
      Navigator.pop(_loadingContext);
    }
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
