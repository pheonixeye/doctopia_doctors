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
