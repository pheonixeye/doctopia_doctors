// ignore_for_file: non_constant_identifier_names

import 'package:doctopia_doctors/models/governorate.dart';
import 'package:equatable/equatable.dart';

class Governorates extends Equatable {
  final List<Governorate> data;

  const Governorates({
    required this.data,
  });

  factory Governorates.fromJson(List<dynamic> json) {
    return Governorates(
      data: json.map((e) => Governorate.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        data,
      ];
}
