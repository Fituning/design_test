enum AirConditioningModeEnum {
  off,
  manuel,
  auto,
}

extension AirConditioningModeEnumExtension on AirConditioningModeEnum {
  static AirConditioningModeEnum fromString(String mode) {
    switch (mode) {
      case 'off':
        return AirConditioningModeEnum.off;
      case 'manuel':
        return AirConditioningModeEnum.manuel;
      case 'auto':
        return AirConditioningModeEnum.auto;
      default:
        throw Exception('Invalid air conditioning mode: $mode');
    }
  }
}
