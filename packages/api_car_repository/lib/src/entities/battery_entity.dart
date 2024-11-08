
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
      'charging_time': chargingTime,
      'charging_power': chargingPower,
    };
  }

  factory BatteryEntity.fromJson(Map<String, dynamic> json) {
    return BatteryEntity(
      chargeLevel: json['charge_level'] as int,
      batteryHealth: json['battery_health'] as int,
      chargingTime: json['charging_time'] as DateTime?,
      chargingPower: (json['charging_power'] as num).toDouble(),
    );
  }
}
