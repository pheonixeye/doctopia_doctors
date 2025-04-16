import 'package:doctopia_doctors/api/_pocket_main/pocket_main.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/attendance_type.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/city.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/degree.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/governorate.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/invoice_status.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/review_status.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/site_service.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/speciality.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/visit_status.dart';
import 'package:doctopia_doctors/models/app_constants_model/_models/visit_type.dart';
import 'package:doctopia_doctors/models/app_constants_model/app_constants_model.dart';

class AppConstantsApi {
  const AppConstantsApi();

  static const String _specialitiesCollection = 'specialities';
  static const String _degreesCollection = 'degrees';
  static const String _governoratesCollection = 'governorates';
  static const String _citiesCollection = 'cities';
  static const String _attendanceTypeCollection = 'attendance_type';
  static const String _invoiceStatusCollection = 'invoice_status';
  static const String _reviewStatusCollection = 'review_status';
  static const String _visitStatusCollection = 'visit_status';
  static const String _visitTypeCollection = 'visit_type';
  static const String _siteServicesCollection = 'site_services';

  Future<AppConstantsResponseModel> fetchBaseModels() async {
    final _specialitiesRequest = await PocketbaseHelper.pb
        .collection(_specialitiesCollection)
        .getFullList(sort: '-created');
    final _specialities = _specialitiesRequest
        .map((e) => Speciality.fromJson(e.toJson()))
        .toList();

    final _governoratesRequest = await PocketbaseHelper.pb
        .collection(_governoratesCollection)
        .getFullList();
    final _governorates = _governoratesRequest
        .map((e) => Governorate.fromJson(e.toJson()))
        .toList();

    final _citiesRequest =
        await PocketbaseHelper.pb.collection(_citiesCollection).getFullList();
    final _cities =
        _citiesRequest.map((e) => City.fromJson(e.toJson())).toList();

    final _degreesRequest =
        await PocketbaseHelper.pb.collection(_degreesCollection).getFullList();
    final _degrees =
        _degreesRequest.map((e) => Degree.fromJson(e.toJson())).toList();

    final _attendanceTypeRequest = await PocketbaseHelper.pb
        .collection(_attendanceTypeCollection)
        .getFullList();
    final _attendance_type = _attendanceTypeRequest
        .map((e) => AttendanceType.fromJson(e.toJson()))
        .toList();

    final _invoiceStatusRequest = await PocketbaseHelper.pb
        .collection(_invoiceStatusCollection)
        .getFullList();
    final _invoice_status = _invoiceStatusRequest
        .map((e) => InvoiceStatus.fromJson(e.toJson()))
        .toList();

    final _reviewStatusRequest = await PocketbaseHelper.pb
        .collection(_reviewStatusCollection)
        .getFullList();
    final _review_status = _reviewStatusRequest
        .map((e) => ReviewStatus.fromJson(e.toJson()))
        .toList();

    final _visitStatusRequest = await PocketbaseHelper.pb
        .collection(_visitStatusCollection)
        .getFullList();
    final _visit_status = _visitStatusRequest
        .map((e) => VisitStatus.fromJson(e.toJson()))
        .toList();

    final _visitTypeRequest = await PocketbaseHelper.pb
        .collection(_visitTypeCollection)
        .getFullList();
    final _visit_type =
        _visitTypeRequest.map((e) => VisitType.fromJson(e.toJson())).toList();

    final _siteServicesRequest = await PocketbaseHelper.pb
        .collection(_siteServicesCollection)
        .getFullList();
    final _siteServices = _siteServicesRequest
        .map((e) => SiteService.fromJson(e.toJson()))
        .toList();

    return AppConstantsResponseModel(
      governorates: _governorates,
      cities: _cities,
      specialities: _specialities,
      degrees: _degrees,
      attendance_types: _attendance_type,
      invoice_status: _invoice_status,
      review_status: _review_status,
      visit_status: _visit_status,
      visit_type: _visit_type,
      site_services: _siteServices,
    );
  }
}
