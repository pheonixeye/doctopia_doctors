import 'package:equatable/equatable.dart';

class ModelTranslatable extends Equatable {
  final String en;
  final String ar;

  const ModelTranslatable({required this.en, required this.ar});

  static const ModelTranslatable X = ModelTranslatable(en: '', ar: '');

  @override
  List<Object?> get props => [en, ar];
}
