// ignore_for_file: prefer_constructors_over_static_methods

class Schedule {
  Schedule(
      {required this.day,
      required this.intday,
      required this.start,
      required this.end});

  factory Schedule.fromJson(dynamic json) {
    return Schedule(
      day: json["day"] as String,
      intday: json["intday"] as int,
      start: json["start"] as int,
      end: json["end"] as int,
    );
  }
  final String day;
  final int intday;
  final int start;
  final int end;
  Map<String, dynamic> toJson() {
    return {
      "day": day,
      "intday": intday,
      "start": start,
      "end": end,
    };
  }

  static List<Schedule> schList(List<dynamic>? dynList) {
    if (dynList == null) {
      return [];
    }
    final List<Schedule> sl = dynList.map((json) {
      return Schedule(
        day: json["day"] as String,
        intday: json["intday"] as int,
        start: json["start"] as int,
        end: json["end"] as int,
      );
    }).toList();
    return sl;
  }
}

class Appointment {
  Appointment({
    required this.docid,
    required this.docname,
    required this.clinic,
    required this.name,
    required this.phone,
    required this.date,
    required this.schedule,
  });
  final int docid;
  final String docname;
  final String clinic;
  final String name;
  final String phone;
  final String date;
  final Schedule schedule;

  static Appointment fromJson(dynamic json) {
    return Appointment(
      docid: json['docid'] as int,
      docname: json['docname'] as String,
      clinic: json['clinic'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      date: json['date'] as String,
      schedule: Schedule.fromJson(json['schedule']),
    );
  }

  factory Appointment.fromNotification(Map<String, dynamic> data) {
    return Appointment(
      docid: int.parse(data['docid']),
      docname: data['docname'],
      clinic: data['clinic'],
      name: data['name'],
      phone: data['phone'],
      date: data['date'],
      schedule: Schedule(
        day: data['day'],
        intday: int.parse(data['intday']),
        start: int.parse(data['start']),
        end: int.parse(data['end']),
      ),
    );
  }

  String toSMS() {
    final DateTime d = DateTime.parse(date);
    return """Booking:\nName: $name\nPhone: $phone\nDoctor: $docname\nClinic: $clinic\nDay: ${schedule.day}\nDate: ${d.day}/${d.month}/${d.year}""";
  }

  Map<String, dynamic> toJson() {
    return {
      'docid': docid,
      'docname': docname,
      'clinic': clinic,
      'name': name,
      'phone': phone,
      'date': date,
      'schedule': schedule.toJson(),
    };
  }
}
