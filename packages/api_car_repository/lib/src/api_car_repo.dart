import 'dart:convert';
import 'dart:developer';
import 'package:api_car_repository/src/repositories/doors_repo.dart';
import 'package:api_car_repository/src/repositories/repositories.dart';
import 'package:api_user_repository/api_user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiCarRepo implements CarRepository {
  final String apiUrl;
  final ApiUserRepo _apiUserRepo;

  late final AirConditioningRepo airConditioningRepo;
  // late final BatteryRepo batteryRepo;
  late final ACProgRepo acProgRepo;
  late final DoorsRepo doorsRepo;

  ApiCarRepo(this._apiUserRepo)
      : apiUrl = '${dotenv.env["API_KEY"]!}/api/cars' {
    airConditioningRepo = AirConditioningRepo(apiUrl, _apiUserRepo);

    // batteryRepo = BatteryRepo(apiUrl, apiUserRepo);
    acProgRepo = ACProgRepo('${dotenv.env["API_KEY"]!}/api/ac_prog', _apiUserRepo);
    doorsRepo = DoorsRepo('$apiUrl/door', _apiUserRepo);
  }

  @override
  Future<List<Car>> getCars() async {
    try {
      final token = await _apiUserRepo.getJwtToken();
      final response = await http.get(
        Uri.parse('$apiUrl/cars'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token" // Ajouter le token ici
        },
      );

      if (response.statusCode == 200) {
        // Decode the JSON response as a Map, since we are expecting a single Car object
        // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // print(jsonResponse["data"]);

        List<dynamic> jsonlist = jsonResponse["data"];

        // print(jsonlist);

        return jsonlist
                .map((carData) => Car.fromEntity(CarEntity.fromJson(carData)))
                .toList();

        // Parse the JSON into a Car object and return it
        // return jsonResponse
        //     .map((carData) => Car.fromEntity(CarEntity.fromJson(carData)))
        //     .toList();
        throw Exception(response.body);
      } else {
        // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // return Car.fromEntity(CarEntity.fromJson(jsonResponse));
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Car> getCar() async {
    try {
      final token = await _apiUserRepo.getJwtToken();
      final response = await http.get(
          // Uri.parse('$apiUrl/${dotenv.env["TEST_CAR_ID"]}'),
        Uri.parse(apiUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token" // Ajouter le token ici
          },
      );

      if (response.statusCode == 200) {
        // Decode the JSON response as a Map, since we are expecting a single Car object
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // print(jsonResponse["data"]);


        // Parse the JSON into a Car object and return it
        return Car.fromEntity(CarEntity.fromJson(jsonResponse["data"]));
      } else {
        // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // return Car.fromEntity(CarEntity.fromJson(jsonResponse));
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Battery> updateBattery() {
    // TODO: implement updateBattery
    throw UnimplementedError();
  }


}
