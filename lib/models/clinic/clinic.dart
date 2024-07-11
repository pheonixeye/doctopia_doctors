// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/models/destination.dart';
import 'package:doctopia_doctors/models/schedule/schedule.dart';
import 'package:doctopia_doctors/models/translatable/translatable.dart';
import 'package:equatable/equatable.dart';

class Clinic extends Equatable {
  final String id;
  final String doc_id;
  final String name_en;
  final String name_ar;
  final String mobile;
  final String landline;
  final bool attendance;
  final bool published;
  final int consultation_fees;
  final int followup_fees;
  final int discount;
  final int waiting_time;
  final int followup_duration;
  final List<String> off_dates;
  final Destination destination;
  final List<Schedule> schedule;

  const Clinic({
    required this.id,
    required this.doc_id,
    required this.name_en,
    required this.name_ar,
    required this.mobile,
    required this.landline,
    required this.attendance,
    required this.published,
    required this.consultation_fees,
    required this.followup_fees,
    required this.discount,
    required this.waiting_time,
    required this.followup_duration,
    required this.off_dates,
    required this.destination,
    required this.schedule,
  });

  Clinic copyWith({
    String? id,
    String? doc_id,
    String? name_en,
    String? name_ar,
    String? mobile,
    String? landline,
    bool? attendance,
    bool? published,
    int? consultation_fees,
    int? followup_fees,
    int? discount,
    int? waiting_time,
    int? followup_duration,
    List<String>? off_dates,
    String? gov_en,
    String? gov_ar,
    String? city_en,
    String? city_ar,
    String? address_en,
    String? address_ar,
    double? lon,
    double? lat,
    List<Schedule>? schedule,
  }) {
    return Clinic(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      mobile: mobile ?? this.mobile,
      landline: landline ?? this.landline,
      attendance: attendance ?? this.attendance,
      published: published ?? this.published,
      consultation_fees: consultation_fees ?? this.consultation_fees,
      followup_fees: followup_fees ?? this.followup_fees,
      discount: discount ?? this.discount,
      waiting_time: waiting_time ?? this.waiting_time,
      followup_duration: followup_duration ?? this.followup_duration,
      off_dates: off_dates ?? this.off_dates,
      destination: destination.copyWith(
        id: id ?? this.id,
        govEn: gov_en ?? destination.govEn,
        govAr: gov_ar ?? destination.govAr,
        areaEn: city_en ?? destination.areaEn,
        areaAr: city_ar ?? destination.areaAr,
        addressEn: address_en ?? destination.addressEn,
        addressAr: address_ar ?? destination.addressAr,
        lat: lat ?? destination.lat,
        lon: lon ?? destination.lon,
      ),
      schedule: schedule ?? this.schedule,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'name_en': name_en,
      'name_ar': name_ar,
      'mobile': mobile,
      'landline': landline,
      'attendance': attendance,
      'published': published,
      'consultation_fees': consultation_fees,
      'followup_fees': followup_fees,
      'discount': discount,
      'waiting_time': waiting_time,
      'followup_duration': followup_duration,
      'off_dates': off_dates,
      'destination': destination.toJson(),
      'schedule': schedule.map((x) => x.toJson()).toList(),
    };
  }

  Map<String, dynamic> toPocketbaseJson() {
    final json = toJson()
      ..remove("id")
      ..addAll({"doc_rel": doc_id});
    return json;
  }

  factory Clinic.fromJson(Map<String, dynamic> map) {
    return Clinic(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      mobile: map['mobile'] as String,
      landline: map['landline'] as String,
      attendance: map['attendance'] as bool,
      published: map['published'] as bool,
      consultation_fees: map['consultation_fees'] as int,
      followup_fees: map['followup_fees'] as int,
      discount: map['discount'] as int,
      waiting_time: map['waiting_time'] as int,
      followup_duration: map['followup_duration'] as int,
      off_dates:
          (map['off_dates'] as List<dynamic>).map((e) => e.toString()).toList(),
      destination: Destination.fromJson(map['destination']),
      schedule: (map['schedule'] as List<dynamic>)
          .map((e) => Schedule.fromJson(e))
          .toList(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      name_en,
      name_ar,
      mobile,
      landline,
      attendance,
      published,
      consultation_fees,
      followup_fees,
      discount,
      waiting_time,
      followup_duration,
      off_dates,
      destination,
      schedule,
    ];
  }

  factory Clinic.initial() {
    return Clinic(
      id: '',
      doc_id: '',
      name_en: '',
      name_ar: '',
      mobile: '',
      landline: '',
      attendance: false,
      published: false,
      consultation_fees: 0,
      followup_fees: 0,
      discount: 0,
      off_dates: const [],
      waiting_time: 0,
      followup_duration: 0,
      destination: Destination.initial(),
      schedule: const [],
    );
  }

  static const List<String> editableStrings = [
    "name_en",
    "name_ar",
    "mobile",
    "landline",
    "address_en",
    "address_ar",
    "consultation_fees",
    "followup_fees",
    "followup_duration",
    "discount",
  ];
  static const List<String> editableDropdowns = [
    "gov_en",
    "area_en",
    "attendance",
  ];

  static const List<String> editabList = [
    'off_dates',
  ];

  static const Map<String, ModelTranslatable> _forWidgets = {
    'doc_id': ModelTranslatable.X,
    'speciality_en': ModelTranslatable.X,
    'speciality_ar': ModelTranslatable.X,
    'name_en': ModelTranslatable(
        en: 'Clinic English Name', ar: 'اسم العيادة بالانجليزية'),
    'name_ar':
        ModelTranslatable(en: 'Clinic Arabic Name', ar: 'اسم العيادة بالعربية'),
    'gov_en': ModelTranslatable(
        en: 'Governorate in English', ar: 'المحافظة بالانجليزية'),
    'gov_ar':
        ModelTranslatable(en: 'Governorate in Arabic', ar: 'المحافظة بالعربية'),
    'area_en':
        ModelTranslatable(en: 'Area in English', ar: 'المنطقة بالانجليزية'),
    'area_ar': ModelTranslatable(en: 'Area in Arabic', ar: 'المنطقة بالعربية'),
    'mobile':
        ModelTranslatable(en: 'Clinic Mobile Number', ar: 'رقم موبايل العيادة'),
    'landline': ModelTranslatable(
        en: 'Clinic Landline Number', ar: 'رقم الارضي للعيادة'),
    'address_en':
        ModelTranslatable(en: 'Address in English', ar: 'العنوان بالانجليزية'),
    'address_ar':
        ModelTranslatable(en: 'Address in Arabic', ar: 'العنوان بالعربية'),
    'attendance': ModelTranslatable(en: 'Attendance Mode', ar: 'طريقة الحضور'),
    'published':
        ModelTranslatable(en: 'Clinic Publish Status', ar: 'حالة النشر'),
    'consultation_fees':
        ModelTranslatable(en: 'Consultation Fees', ar: 'سعر الكشف'),
    'followup_fees':
        ModelTranslatable(en: 'Follow Up Fees', ar: 'سعر الاستشارة'),
    'followup_duration':
        ModelTranslatable(en: 'Follow Up Duration', ar: 'مدة الاستشارة'),
    'discount': ModelTranslatable(en: 'Discount %', ar: 'نسبة الخصم'),
    'off_dates': ModelTranslatable(en: 'Off Dates', ar: 'اجازات العيادة'),
  };

  static String keyToWidget(String key, bool isEnglish) {
    return isEnglish ? _forWidgets[key]!.en : _forWidgets[key]!.ar;
  }
}
