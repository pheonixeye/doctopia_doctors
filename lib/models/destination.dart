import 'package:equatable/equatable.dart';

class Destination extends Equatable {
  final String govEn;
  final String areaEn;
  final String govAr;
  final String areaAr;
  final String addressEn;
  final String addressAr;

  const Destination({
    required this.govEn,
    required this.govAr,
    required this.areaEn,
    required this.areaAr,
    required this.addressEn,
    required this.addressAr,
  });

  Destination copyWith({
    String? govEn,
    String? govAr,
    String? areaEn,
    String? areaAr,
    String? addressEn,
    String? addressAr,
  }) {
    return Destination(
      govEn: govEn ?? this.govEn,
      govAr: govAr ?? this.govAr,
      areaEn: areaEn ?? this.areaEn,
      areaAr: areaAr ?? this.areaAr,
      addressEn: addressEn ?? this.addressEn,
      addressAr: addressAr ?? this.addressAr,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'govEn': govEn,
      'govAr': govAr,
      'areaEn': areaEn,
      'areaAr': areaAr,
      'addressEn': addressEn,
      'addressAr': addressAr,
    };
  }

  factory Destination.fromJson(Map<String, dynamic> map) {
    return Destination(
      govEn: map['govEn'] as String,
      govAr: map['govAr'] as String,
      areaEn: map['areaEn'] as String,
      areaAr: map['areaAr'] as String,
      addressEn: map['addressEn'] as String,
      addressAr: map['addressAr'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        govEn,
        areaEn,
        addressEn,
        addressAr,
        govAr,
        areaAr,
      ];
}
