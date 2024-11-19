import 'package:api_car_repository/api_car_repository.dart';

class Car{
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

  Car({
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

  CarEntity toEntity(){
    return CarEntity(
        vin: vin,
        color: color,
        kilometres: kilometres,
        lastInterview: lastInterview,
        softwareStatus: softwareStatus,
        averageConsumption: averageConsumption,
        remainingRange: remainingRange,
        gpsLocation: gpsLocation,
        rightDoor: rightDoor,
        leftDoor: leftDoor,
        hood: hood,
        chargingSocketIsConnected: chargingSocketIsConnected,
        chargeIsActivated: chargeIsActivated,
        battery: battery,
        airConditioning: airConditioning,
    );
  }

  static Car fromEntity(CarEntity entity){
    return Car(
      vin: entity.vin,
      color: entity.color,
      kilometres: entity.kilometres,
      lastInterview: entity.lastInterview,
      softwareStatus: entity.softwareStatus,
      averageConsumption: entity.averageConsumption,
      remainingRange: entity.remainingRange,
      gpsLocation: entity.gpsLocation,
      rightDoor: entity.rightDoor,
      leftDoor: entity.leftDoor,
      hood: entity.hood,
      chargingSocketIsConnected: entity.chargingSocketIsConnected,
      chargeIsActivated: entity.chargeIsActivated,
      battery: entity.battery,
      airConditioning: entity.airConditioning,
    );
  }
}


class GpsLocation {
  final List<double> coordinates;

  GpsLocation({
    required this.coordinates,
  }) : assert(coordinates.length == 2, 'Position GPS must contain latitude and longitude');

  factory GpsLocation.defaultLocation() {
    return GpsLocation(coordinates: [47.06612603801956, 7.107213090213195]);
  }

  /// Méthode pour convertir en JSON
  Map<String, dynamic> toJson() {
    return {
      'gps_location': coordinates, // Convertir la liste de coordonnées directement
    };
  }

  /// Validation function
  bool isValid() {
    return coordinates.length == 2;
  }

  /// Error message for validation
  String get validationMessage {
    return isValid() ? '' : 'Position GPS must contain both latitude and longitude';
  }
}
