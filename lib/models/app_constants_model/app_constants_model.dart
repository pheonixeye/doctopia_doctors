// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:equatable/equatable.dart';

class AppConstantsResponseModel extends Equatable {
  final List<Governorate> governorates;
  final List<City> cities;
  final List<Speciality> specialities;
  final List<Degree> degrees;
  final List<AttendanceType> attendance_types;
  final List<InvoiceStatus> invoice_status;
  final List<ReviewStatus> review_status;
  final List<VisitStatus> visit_status;
  final List<VisitType> visit_type;
  final List<SiteService> site_services;

  const AppConstantsResponseModel({
    required this.governorates,
    required this.cities,
    required this.specialities,
    required this.degrees,
    required this.attendance_types,
    required this.invoice_status,
    required this.review_status,
    required this.visit_status,
    required this.visit_type,
    required this.site_services,
  });

  @override
  List<Object> get props {
    return [
      governorates,
      cities,
      specialities,
      degrees,
      attendance_types,
      invoice_status,
      review_status,
      visit_status,
      visit_type,
      site_services,
    ];
  }
}
