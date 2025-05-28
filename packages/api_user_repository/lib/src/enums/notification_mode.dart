enum NotificationModeEnum {
  on,
  off,
  onlyAlert,
}

extension NotificationModeEnumExtension on NotificationModeEnum {
  static NotificationModeEnum fromString(String mode) {
    switch (mode) {
      case 'on':
        return NotificationModeEnum.on;
      case 'off':
        return NotificationModeEnum.off;
      case 'only_alert':
        return NotificationModeEnum.onlyAlert;
      default:
        throw Exception('Invalid notification mode: $mode');
    }
  }
}
