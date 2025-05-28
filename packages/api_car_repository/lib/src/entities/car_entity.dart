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
  List<ACProg?> acProg;

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
    required this.acProg
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
      'gps_latitude': gpsLocation.coordinates[0],
      'gps_latitude': gpsLocation.coordinates[1],
      'right_door': rightDoor.name,
      'left_door': leftDoor.name,
      'hood': hood.name,
      'charging_socket_is_connected': chargingSocketIsConnected,
      'charge_is_activated': chargeIsActivated,
      'battery': battery.toEntity().toJson(),
      'air_conditioning': airConditioning.toEntity().toJson(),
      // 'ac_prog': acProg.map((prog) => prog?.toEntity().toJson())//todo
    };
  }

  factory CarEntity.fromJson(Map<String, dynamic> json) {

    // Parse GPS coordinates safely
    print(json);
    // List<dynamic> gpsCoordinates = json['gps_location'];
    // List<dynamic> gpsCoordinates = [json['gps_latitude'], json['gps_latitude']];
    GpsLocation gpsLocation = GpsLocation(
      // coordinates: gpsCoordinates.map((coord) => coord as double).toList(),
         coordinates: [json['gps_latitude'], json['gps_longitude']],
    );

    // Vérifier si 'ac_prog' existe et est une liste avant de la traiter
    List<ACProg>? acProgList;
    if (json.containsKey('ac_prog')) {
      acProgList = (json['ac_prog'] as List)
          .map((acProgJson) {
        if (acProgJson is Map<String, dynamic>) {
          // Si c'est un objet peuplé, on récupère uniquement l'_id
          return ACProg.fromEntity(ACProgEntity.fromJson(acProgJson));
        }
        else if (acProgJson is String) {
          // Si c'est déjà une chaîne (ID), on la garde
          return [] as ACProg;
        }
        else {
          throw Exception("Type inattendu dans la liste 'cars': ${acProgJson.runtimeType}");
        }
      }).toList() ;
    } else {
      acProgList = []; // Retourner une liste vide si 'ac_prog' n'existe pas ou n'est pas valide
    }

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
      acProg: acProgList,
    );

    return car;
  }
}