import 'package:equatable/equatable.dart';

class ClinicLocation extends Equatable {
  final double lon;
  final double lat;

  const ClinicLocation({
    required this.lon,
    required this.lat,
  });

  ClinicLocation copyWith({
    double? lon,
    double? lat,
  }) {
    return ClinicLocation(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lon': lon,
      'lat': lat,
    };
  }

  factory ClinicLocation.fromJson(Map<String, dynamic> map) {
    return ClinicLocation(
      lon: map['lon'] as double,
      lat: map['lat'] as double,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [lon, lat];

  factory ClinicLocation.initial() {
    return const ClinicLocation(lon: 0, lat: 0);
  }
}
