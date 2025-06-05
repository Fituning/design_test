String formatHourMinute(DateTime? dateTime) {
  if (dateTime == null) return "00:00";
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}