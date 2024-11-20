import 'package:api_car_repository/api_car_repository.dart';

abstract class CarRepository{
  Future<List<Car>> getCars();
  Future<Car> getCar();
  Future<AirConditioning> updateAirConditioning();
  Future<Battery> updateBattery();

}