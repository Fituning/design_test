
import 'package:api_car_repository/src/enums/enum.dart';

class AirConditioningEntity {
  int temperature;
  AirConditioningModeEnum mode;

  VentilationLevelEnum ventilationLevel;
  bool acIsActive;
  bool frontDefogging;
  bool backDefogging;

  AirConditioningEntity({
    required this.temperature,
    required this.mode,
    required this.ventilationLevel,
    required this.acIsActive,
    required this.frontDefogging,
    required this.backDefogging,
  });

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'mode': mode.name, // Convert enum to string
      'ventilation_level': ventilationLevel.name,
      'ac_is_active': acIsActive,
      'front_defogging': frontDefogging,
      'back_defogging': backDefogging,
    };
  }

  factory AirConditioningEntity.fromJson(Map<String, dynamic> json) {
    return AirConditioningEntity(
      temperature: json['temperature'] as int,
      mode: AirConditioningModeEnumExtension.fromString(json['mode']),
      ventilationLevel: VentilationLevelEnumExtension.fromString(json['ventilation_level']),
      acIsActive: json['ac_is_active'] as bool,
      frontDefogging: json['front_defogging'] as bool,
      backDefogging: json['back_defogging'] as bool,
    );
  }

  // // Helper function to convert string to AirConditioningModeEnum
  // static AirConditioningModeEnum _stringToModeEnum(String mode) {
  //   switch (mode) {
  //     case 'off':
  //       return AirConditioningModeEnum.off;
  //     case 'manuel':
  //       return AirConditioningModeEnum.manuel;
  //     case 'auto':
  //       return AirConditioningModeEnum.auto;
  //     default:
  //       throw ArgumentError('Unknown mode: $mode');
  //   }
  // }
}

