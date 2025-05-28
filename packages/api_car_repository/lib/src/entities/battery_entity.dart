
class BatteryEntity {
  int chargeLevel;
  int batteryHealth;
  DateTime? chargingTime;
  double chargingPower;

  BatteryEntity({
    required this.chargeLevel,
    required this.batteryHealth,
    required this.chargingTime,
    required this.chargingPower,
  });

  Map<String, dynamic> toJson() {
    return {
      'charge_level': chargeLevel,
      'battery_health': batteryHealth,
      'charging_time': chargingTime!.millisecondsSinceEpoch ~/ 60000,
      'charging_power': chargingPower,
    };
  }

  factory BatteryEntity.fromJson(Map<String, dynamic> json) {
    return BatteryEntity(
      chargeLevel: json['charge_level'] as int,
      batteryHealth: json['battery_health'] as int,
      chargingTime: DateTime.fromMillisecondsSinceEpoch(json['charging_time'] * 60000) as DateTime?, // *60000 because de function expect time in miliseconds
      chargingPower: (json['charging_power'] as num).toDouble(),
    );
  }


}
