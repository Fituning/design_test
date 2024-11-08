import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:api_car_repository/api_car_repository.dart';

class ApiCarRepo implements CarRepository {
  final String apiUrl = 'https://ocr-api-4fox.onrender.com/api/car'; // Replace with your API URL

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
      final response = await http.get(Uri.parse('$apiUrl/672a183e50544b8598a27d90'));

      if (response.statusCode == 200) {
        // Decode the JSON response as a Map, since we are expecting a single Car object
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Parse the JSON into a Car object and return it
        return Car.fromEntity(CarEntity.fromJson(jsonResponse));
      } else {
        throw Exception('Failed to load car');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Car> updateAirConditioning({
    int? temperature,
    AirConditioningModeEnum? mode,
    VentilationLevelEnum? ventilationLevel,
    bool? acIsActive,
    bool? frontDefogging,
    bool? backDefogging,
  }) async {
    try {
      // Créez l'URL en utilisant votre API
      final url = Uri.parse('$apiUrl/672a183e50544b8598a27d90/update/air_conditioning');

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

      print(jsonBody);

      // Faites une requête PATCH ou POST avec le corps en JSON
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"}, // En-tête pour indiquer que le corps est en JSON
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Décodez la réponse JSON en tant que Map, car nous attendons un objet Car
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Analysez le JSON en un objet Car et retournez-le
        print("json response : $jsonResponse");
        return Car.fromEntity(CarEntity.fromJson(jsonResponse));
      } else {
        throw Exception('Failed to update car');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}
