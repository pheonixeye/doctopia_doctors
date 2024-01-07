import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocalDatabase()),
  ChangeNotifierProvider(create: (context) => PxLocale(context)),
  ChangeNotifierProvider(create: (context) => PxTheme(context)),
];
