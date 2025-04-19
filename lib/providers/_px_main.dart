import 'package:doctopia_doctors/api/app_constants_api/app_constants_api.dart';
import 'package:doctopia_doctors/api/server_status_api/status_api.dart';
import 'package:doctopia_doctors/api/user_model_api/user_model_api.dart';
import 'package:doctopia_doctors/providers/px_app_constants.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_overlay.dart';
import 'package:doctopia_doctors/providers/px_server_status.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocalDatabase.instance),
  ChangeNotifierProvider(create: (context) => PxOverlay()),
  ChangeNotifierProvider(
    create: (context) => PxAppConstants(
      service: const AppConstantsApi(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => PxUserModel(
      context: context,
      userService: const HxUserModel(),
    ),
  ),
  ChangeNotifierProvider(create: (context) => PxLocale(context)),
  ChangeNotifierProvider(create: (context) => PxTheme(context)),
  ChangeNotifierProvider(
    create: (context) => PxServerStatus(
      statusService: const HxServerStatus(),
    ),
  ),
];
