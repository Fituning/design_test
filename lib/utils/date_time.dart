String formatHourMinute(Duration? time) {
  if (time == null) return "00:00";
  final hours = time.inHours.toString().padLeft(2, '0');
  final minutes = time.inMinutes.remainder(60).toString().padLeft(2, '0');
  return '$hours:$minutes';
}