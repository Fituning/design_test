enum DaysOfWeekEnum {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension DaysOfWeekEnumExtension on DaysOfWeekEnum {
  static DaysOfWeekEnum fromString(String day) {
    switch (day.toUpperCase()) {
      case 'MON':
        return DaysOfWeekEnum.monday;
      case 'TUE':
        return DaysOfWeekEnum.tuesday;
      case 'WED':
        return DaysOfWeekEnum.wednesday;
      case 'THU':
        return DaysOfWeekEnum.thursday;
      case 'FRI':
        return DaysOfWeekEnum.friday;
      case 'SAT':
        return DaysOfWeekEnum.saturday;
      case 'SUN':
        return DaysOfWeekEnum.sunday;
      default:
        throw Exception('Invalid day: $day');
    }
  }

  String toShortString() {
    switch (this) {
      case DaysOfWeekEnum.monday:
        return 'MON';
      case DaysOfWeekEnum.tuesday:
        return 'TUE';
      case DaysOfWeekEnum.wednesday:
        return 'WED';
      case DaysOfWeekEnum.thursday:
        return 'THU';
      case DaysOfWeekEnum.friday:
        return 'FRI';
      case DaysOfWeekEnum.saturday:
        return 'SAT';
      case DaysOfWeekEnum.sunday:
        return 'SUN';
    }
  }
}
