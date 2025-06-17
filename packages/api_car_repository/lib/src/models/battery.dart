import 'package:api_car_repository/src/entities/entities.dart';


class Battery{
  int chargeLevel;
  int batteryHealth;
  Duration? chargingTime;
  double chargingPower;

  Battery({
    required this.chargeLevel,
    required this.batteryHealth,
    required this.chargingTime,
    required this.chargingPower,
  });

  BatteryEntity toEntity(){
    return BatteryEntity(
        chargeLevel: chargeLevel,
        batteryHealth: batteryHealth,
        chargingTime: chargingTime,
        chargingPower: chargingPower,
    );
  }

  static Battery fromEntity(BatteryEntity entity){
    return Battery(
        chargeLevel: entity.chargeLevel,
        batteryHealth: entity.batteryHealth,
        chargingTime: entity.chargingTime,
        chargingPower: entity.chargingPower
    );
  }


}