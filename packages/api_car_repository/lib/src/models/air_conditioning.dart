import 'package:api_car_repository/src/entities/entities.dart';
import 'package:api_car_repository/src/enums/enum.dart';


class AirConditioning{
  double temperature;
  AirConditioningModeEnum mode;
  VentilationLevelEnum ventilationLevel;
  bool acIsActive;
  bool frontDefogging;
  bool backDefogging;

  AirConditioning({
    required this.temperature,
    required this.mode,
    required this.ventilationLevel,
    required this.acIsActive,
    required this.frontDefogging,
    required this.backDefogging,
  });

  AirConditioningEntity toEntity(){
    return AirConditioningEntity(
        temperature: temperature,
        mode: mode,
        ventilationLevel: ventilationLevel,
        acIsActive: acIsActive,
        frontDefogging: frontDefogging,
        backDefogging: backDefogging,
    );
  }

  static AirConditioning fromEntity(AirConditioningEntity entity){
    return AirConditioning(
        temperature: entity.temperature,
        mode: entity.mode,
        ventilationLevel: entity.ventilationLevel,
        acIsActive: entity.acIsActive,
        frontDefogging: entity.frontDefogging,
        backDefogging: entity.backDefogging,
    );
  }


}