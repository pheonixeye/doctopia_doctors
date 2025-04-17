import 'package:doctopia_doctors/models/app_constants_model/_models/app_constant.dart';
import 'package:equatable/equatable.dart';

class Venue extends AppConstant implements Equatable {
  const Venue({
    required super.id,
    required super.name_en,
    required super.name_ar,
    required this.image,
  });

  final String image;

  @override
  bool get stringify => true;

  factory Venue.fromJson(Map<String, dynamic> map) {
    return Venue(
      id: map['id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      image: map['image'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': name_en,
      'name_ar': name_ar,
      'image': image,
    };
  }

  @override
  List<Object> get props => [...super.props, image];
}
