import 'package:api_car_repository/api_car_repository.dart';

class CarEntity{
  String vin;
  String color;
  double kilometres;
  DateTime? lastInterview;
  SoftwareStatusEnum softwareStatus;
  double averageConsumption;
  double remainingRange;
  GpsLocation gpsLocation;
  DoorStatusEnum rightDoor;
  DoorStatusEnum leftDoor;
  DoorStatusEnum hood;
  bool chargingSocketIsConnected;
  bool chargeIsActivated;
  Battery battery;
  AirConditioning airConditioning;

  CarEntity({
    required this.vin,
    required this.color,
    required this.kilometres,
    required this.lastInterview,
    required this.softwareStatus,
    required this.averageConsumption,
    required this.remainingRange,
    required this.gpsLocation,
    required this.rightDoor,
    required this.leftDoor,
    required this.hood,
    required this.chargingSocketIsConnected,
    required this.chargeIsActivated,
    required this.battery,
    required this.airConditioning,
  });


  Map<String, dynamic> toJson() {
    return{
      'vin': vin,
      'color': color,
      'kilometres': kilometres,
      'last_interview': lastInterview,
      'software_status': softwareStatus.name,
      'average_consumption': averageConsumption,
      'remaining_range': remainingRange,
      'gps_location': gpsLocation.coordinates,
      'right_door': rightDoor.name,
      'left_door': leftDoor.name,
      'hood': hood.name,
      'charging_socket_is_connected': chargingSocketIsConnected,
      'charge_is_activated': chargeIsActivated,
      'battery': battery.toEntity().toJson(),
      'air_conditioning': airConditioning.toEntity().toJson(),
    };
  }

  factory CarEntity.fromJson(Map<String, dynamic> json) {

    // Parse GPS coordinates safely
    List<dynamic> gpsCoordinates = json['gps_location'];
    GpsLocation gpsLocation = GpsLocation(
      coordinates: gpsCoordinates.map((coord) => coord as double).toList(),
    );
    CarEntity car = CarEntity(
      vin: json['vin'] as String,
      color: json['color'] as String,
      kilometres: (json['kilometres'] as num).toDouble(),
      lastInterview: json['last_interview'] as DateTime?,
      softwareStatus: SoftwareStatusEnumExtension.fromString(json['software_status']),
      averageConsumption: (json['average_consumption'] as num).toDouble(),
      remainingRange: (json['remaining_range'] as num).toDouble(),
      gpsLocation: gpsLocation,
      rightDoor: DoorStatusEnumExtension.fromString(json['right_door']),
      leftDoor: DoorStatusEnumExtension.fromString(json['left_door']),
      hood: DoorStatusEnumExtension.fromString(json['hood']),
      chargingSocketIsConnected: json['charging_socket_is_connected'] as bool,
      chargeIsActivated: json['charge_is_activated'] as bool,
      battery: Battery.fromEntity(BatteryEntity.fromJson(json['battery'] as Map<String, dynamic>)),
      airConditioning: AirConditioning.fromEntity(AirConditioningEntity.fromJson(json['air_conditioning'] as Map<String, dynamic> )),
    );

    return car;
  }
}