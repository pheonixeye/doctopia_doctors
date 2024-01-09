import 'package:equatable/equatable.dart';

class Degree extends Equatable {
  final String en;
  final String ar;

  const Degree({
    required this.en,
    required this.ar,
  });

  static List<Degree> list = const [
    Degree(en: 'General Practioner', ar: 'ممارس عام'),
    Degree(en: 'Specialist', ar: 'اخصائي'),
    Degree(en: 'Consultant', ar: 'استشاري'),
  ];

  @override
  List<Object?> get props => [en, ar];
}
