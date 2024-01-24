import 'package:equatable/equatable.dart';

class Weekdays extends Equatable {
  final String d;
  final int i;

  const Weekdays(this.d, this.i);

  @override
  List<Object?> get props => [d, i];

  static const List<Weekdays> list = [
    Weekdays("Monday", 1),
    Weekdays("Tuesday", 2),
    Weekdays("Wednesday", 3),
    Weekdays("Thursday", 4),
    Weekdays("Friday", 5),
    Weekdays("Saturday", 6),
    Weekdays("Sunday", 7),
  ];
}
