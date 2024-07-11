const Map<int, String> _intdayToWeekday = {
  1: "Monday",
  2: "Tuesday",
  3: "Wendensday",
  4: "Thursday",
  5: "Friday",
  6: "Saturday",
  7: "Sunday",
};

String? getWeekday(int key) {
  return _intdayToWeekday[key];
}

/// format time function - takes an hour integer and returns am/pm formatted time
String fT(int hour, int min) {
  return switch (hour) {
    < 12 => '$hour:$min A.M.',
    > 12 => '${hour - 12}:$min P.M.',
    == 12 => '$hour:$min P.M.',
    _ => 'Unsupported Time Format.',
  };
}
