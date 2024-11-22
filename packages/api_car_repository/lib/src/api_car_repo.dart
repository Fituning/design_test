import 'dart:convert';
import 'dart:developer';
import 'package:api_user_repository/api_user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiCarRepo implements CarRepository {
  final String apiUrl = dotenv.env["API_KEY"]! + '/api/car'; // Replace with your API URL
  final ApiUserRepo _apiUserRepo ;

  ApiCarRepo(this._apiUserRepo);

  @override
  Future<List<Car>> getCars() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        return jsonResponse
            .map((carData) => Car.fromEntity(CarEntity.fromJson(carData)))
            .toList();
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Car> getCar() async {
    try {
      print(await _apiUserRepo.user.toString());

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
  Future<AirConditioning> updateAirConditioning({
    int? temperature,
    AirConditioningModeEnum? mode,
    VentilationLevelEnum? ventilationLevel,
    bool? acIsActive,
    bool? frontDefogging,
    bool? backDefogging,
  }) async {
    try {
      final token = await _apiUserRepo.getJwtToken();

      // Créez l'URL en utilisant votre API
      final url = Uri.parse('$apiUrl/update/air_conditioning');

      // Construisez le corps de la requête en JSON de manière dynamique
      final Map<String, dynamic> body = {};

      if (temperature != null) {
        body['temperature'] = temperature;
      }
      if (mode != null) {
        body['mode'] = mode.name;
      }
      if (ventilationLevel != null) {
        body['ventilation_level'] = ventilationLevel.index;
      }
      if (acIsActive != null) {
        body['ac_is_active'] = acIsActive;
      }
      if (frontDefogging != null) {
        body['front_defogging'] = frontDefogging;
      }
      if (backDefogging != null) {
        body['back_defogging'] = backDefogging;
      }

      // Encodez le corps en JSON
      final jsonBody = jsonEncode(body);

      // Faites une requête PATCH ou POST avec le corps en JSON
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token" // Ajouter le token ici
        },// En-tête pour indiquer que le corps est en JSON
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Décodez la réponse JSON en tant que Map, car nous attendons un objet Car
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return AirConditioning.fromEntity(AirConditioningEntity.fromJson(jsonResponse["data"]));//todo ne met pas a jour le car puisque MQTT envoie une notification de changement
      } else {
        throw Exception('Failed to update car');
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
