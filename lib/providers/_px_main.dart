import 'package:doctopia_doctors/api/doctor_api/hx_doctor.dart';
import 'package:doctopia_doctors/api/documents_api/hx_documents.dart';
import 'package:doctopia_doctors/api/speciality_api/speciality.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_specialities.dart';
import 'package:doctopia_doctors/providers/px_theme.dart';
import 'package:doctopia_doctors/services/local_database_service/local_database_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers(ENV env) => [
      ChangeNotifierProvider(create: (context) => PxLocalDatabase()),
      ChangeNotifierProvider(create: (context) => PxLocale(context)),
      ChangeNotifierProvider(create: (context) => PxTheme(context)),
      ChangeNotifierProvider(
        create: (context) => PxSpeciality(
          specialityService: HxSpeciality(
            env: env,
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxDoctor(
          doctorService: HxDoctor(
            env: env,
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxDocuments(
          documentsService: HxDocuments(
            env: env,
          ),
        ),
      ),
    ];
