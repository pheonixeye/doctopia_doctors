import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/api/clinic_images_api/clinic_images_api.dart';
import 'package:doctopia_doctors/api/clinic_visits_api/hx_clinic_visits.dart';
import 'package:doctopia_doctors/api/doctor_api/hx_doctor.dart';
import 'package:doctopia_doctors/api/documents_api/hx_documents.dart';
import 'package:doctopia_doctors/api/governorate_api/governorate_city.dart';
import 'package:doctopia_doctors/api/invoices_api/invoices_api.dart';
import 'package:doctopia_doctors/api/publish_request_api/publish_request_api.dart';
import 'package:doctopia_doctors/api/reviews_api/reviews_api.dart';
import 'package:doctopia_doctors/api/schedule_api/schedule_api.dart';
import 'package:doctopia_doctors/api/server_status_api/status_api.dart';
import 'package:doctopia_doctors/api/speciality_api/speciality.dart';
import 'package:doctopia_doctors/env/env.dart';
import 'package:doctopia_doctors/providers/px_clinic_visits.dart';
import 'package:doctopia_doctors/providers/px_clinic_images.dart';
import 'package:doctopia_doctors/providers/px_clinics.dart';
import 'package:doctopia_doctors/providers/px_doctor.dart';
import 'package:doctopia_doctors/providers/px_documents.dart';
import 'package:doctopia_doctors/providers/px_gov.dart';
import 'package:doctopia_doctors/providers/px_invoices.dart';
import 'package:doctopia_doctors/providers/px_locale.dart';
import 'package:doctopia_doctors/providers/px_publish_request.dart';
import 'package:doctopia_doctors/providers/px_reviews.dart';
import 'package:doctopia_doctors/providers/px_schedule.dart';
import 'package:doctopia_doctors/providers/px_server_status.dart';
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
        create: (context) => PxServerStatus(
          statusService: HxServerStatus(
            env: env,
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxGov(
          govCityService: HxGovCity(
            env: env,
          ),
        ),
      ),
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
      ChangeNotifierProvider(
        create: (context) => PxClinics(
          clinicService: HxClinic(
            env: env,
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxClinicImages(
          clinicImagesService: HxClinicImages(
            env: env,
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxSchedule(
          scheduleService: HxSchedule(
            env: env,
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxClinicVisits(
          visitsService: HxClinicVisits(
            env: env,
          ),
          doc_id: context.read<PxDoctor>().doctor.id!,
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxPublishRequest(
          publishRequestService: HxPublishRequest(
            env: env,
          ),
          doc_id: context.read<PxDoctor>().doctor.id!,
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxReviews(
          reviewsService: HxReviews(
            env: env,
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => PxInvoices(
          invoicesService: HxInvoices(
            env: env,
          ),
          doc_id: context.read<PxDoctor>().doctor.id!,
        ),
      ),
    ];
