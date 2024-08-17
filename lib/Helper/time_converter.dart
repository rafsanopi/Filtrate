import 'package:flutter/material.dart';

List<Map<String, dynamic>> serviceHours = [
  {"day": "Sun", "start": TimeOfDay.now(), "end": TimeOfDay.now()},
  {"day": "Mon", "start": TimeOfDay.now(), "end": TimeOfDay.now()},
  {"day": "Tue", "start": TimeOfDay.now(), "end": TimeOfDay.now()},
  {"day": "Wed", "start": TimeOfDay.now(), "end": TimeOfDay.now()},
  {"day": "Thu", "start": TimeOfDay.now(), "end": TimeOfDay.now()},
  {"day": "Fri", "start": TimeOfDay.now(), "end": TimeOfDay.now()},
  {"day": "Sat", "start": TimeOfDay.now(), "end": TimeOfDay.now()},
];

TimeOfDay convertToTimeOfDay(String timeString) {
  List<String> timeComponents = timeString.split(':');

  int hours = int.parse(timeComponents[0]);
  int minutes = int.parse(timeComponents[1]);

  return TimeOfDay(hour: hours, minute: minutes);
}

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

List<Map<String, dynamic>> stringToTimeDate(
    List<dynamic>? availableServiceOurList) {
  List<Map<String, dynamic>> convertedList = [];

  if (availableServiceOurList != null) {
    for (var availableServiceOur in availableServiceOurList) {
      String day = availableServiceOur.day ?? "";
      String startTimeString = availableServiceOur.startTime ?? "";
      String endTimeString = availableServiceOur.endTime ?? "";

      TimeOfDay startTime = convertToTimeOfDay(startTimeString);
      TimeOfDay endTime = convertToTimeOfDay(endTimeString);

      convertedList.add({
        'day': day,
        'start': startTime,
        'end': endTime,
      });
    }
  }

  return convertedList;
}

List<Map<String, dynamic>> timeDateToString(
    {required List<Map<String, dynamic>> response}) {
  List<Map<String, dynamic>> convertedValue = [];

  for (var data in response) {
    convertedValue.add({
      "Day": data["day"],
      "Start Time": formatTimeOfDay(data["start"]),
      "End Time": formatTimeOfDay(data["end"]),
    });
  }

  return convertedValue;
}
