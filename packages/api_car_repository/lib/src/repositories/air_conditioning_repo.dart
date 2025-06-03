import 'package:api_car_repository/api_car_repository.dart';
import 'package:api_car_repository/src/repositories/base_repo.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


abstract class AirConditioningRepository extends BaseRepository{
  AirConditioningRepository(super.apiUrl, super.apiUserRepo);

  Future<AirConditioning> updateAirConditioning();
}

class AirConditioningRepo extends AirConditioningRepository{

  AirConditioningRepo(super.apiUrl, super.apiUserRepo);


  @override
  Future<AirConditioning> updateAirConditioning({
    double? temperature,
    AirConditioningModeEnum? mode,
    VentilationLevelEnum? ventilationLevel,
    bool? acIsActive,
    bool? frontDefogging,
    bool? backDefogging,
  }) async {
    try {
      final token = await apiUserRepo.getJwtToken();

      // Créez l'URL en utilisant votre API
      final url = Uri.parse('$apiUrl/air_conditioning');

      // Construisez le corps de la requête en JSON de manière dynamique
      final Map<String, dynamic> body = {};

      if (temperature != null) {
        body['temperature'] = temperature.toString();
      }
      if (mode != null) {
        body['mode'] = mode.name;
      }
      if (ventilationLevel != null) {
        body['ventilation_level'] = ventilationLevel.name;
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

      final prefs = await SharedPreferences.getInstance();
      String? deviceUUID = prefs.getString('device_uuid');

      // Faites une requête PATCH ou POST avec le corps en JSON
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "source": deviceUUID ?? "frontend", // add device uuid to avoid autorefresh
          "Authorization": "Bearer $token" // Ajouter le token ici
        },// En-tête pour indiquer que le corps est en JSON
        body: jsonBody,
      );

      print(jsonBody);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // Décodez la réponse JSON en tant que Map, car nous attendons un objet Car
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return AirConditioning.fromEntity(AirConditioningEntity.fromJson(jsonResponse["data"]["air_conditioning"]));//todo ne met pas a jour le car puisque MQTT envoie une notification de changement
      } else {
        throw Exception('Failed to update car');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}