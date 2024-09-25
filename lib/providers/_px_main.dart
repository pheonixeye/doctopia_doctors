import 'package:doctopia_doctors/api/governorate_api/governorate_city.dart';
import 'package:doctopia_doctors/api/server_status_api/status_api.dart';
import 'package:doctopia_doctors/api/speciality_api/speciality.dart';
import 'package:doctopia_doctors/api/user_model_api/user_model_api.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_overlay.dart';
import 'package:doctopia_doctors/providers/px_server_status.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/providers/px_user_model.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocalDatabase.instance),
  ChangeNotifierProvider(create: (context) => PxOverlay()),
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
  ChangeNotifierProvider(
    create: (context) => PxGov(
      govCityService: const HxGovCity(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => PxSpeciality(
      specialityService: const HxSpeciality(),
    ),
  ),
];
