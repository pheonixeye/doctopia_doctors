import 'package:equatable/equatable.dart';

class ClinicShift extends Equatable {
  final String id;
  final num startH;
  final num startM;
  final num endH;
  final num endM;
  final num patients;

  const ClinicShift({
    required this.id,
    required this.startH,
    required this.startM,
    required this.endH,
    required this.endM,
    required this.patients,
  });

  ClinicShift copyWith({
    String? id,
    num? startH,
    num? startM,
    num? endH,
    num? endM,
    num? patients,
  }) {
    return ClinicShift(
      id: id ?? this.id,
      startH: startH ?? this.startH,
      startM: startM ?? this.startM,
      endH: endH ?? this.endH,
      endM: endM ?? this.endM,
      patients: patients ?? this.patients,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'startH': startH,
      'startM': startM,
      'endH': endH,
      'endM': endM,
      'patients': patients,
    };
  }

  factory ClinicShift.fromJson(Map<String, dynamic> map) {
    return ClinicShift(
      id: map['_id'] as String,
      startH: map['startH'] as num,
      startM: map['startM'] as num,
      endH: map['endH'] as num,
      endM: map['endM'] as num,
      patients: map['patients'] as num,
    );
  }

  factory ClinicShift.initial() {
    return const ClinicShift(
      id: '',
      startH: 0,
      startM: 0,
      endH: 0,
      endM: 0,
      patients: 0,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      startH,
      startM,
      endH,
      endM,
      patients,
    ];
  }
}
