import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_car_repository.dart';
import 'base_repo.dart';

abstract class DoorsRepository extends BaseRepository {
  DoorsRepository(super.apiUrl, super.apiUserRepo);

  // Future<AirConditioning> updateAirConditioning();
  Future<Car> updateDoorState({required DoorEnum door});
}


class DoorsRepo extends DoorsRepository{

  DoorsRepo(super.apiUrl, super.apiUserRepo);

  @override
  Future<Car> updateDoorState({
    required DoorEnum door,
  })async{
    try{
      final token = await apiUserRepo.getJwtToken();

      Uri url;

      if( door == DoorEnum.right ){
        url = Uri.parse('$apiUrl/right_door');
      }else if( door == DoorEnum.left ){
        url = Uri.parse('$apiUrl/left_door');
      }else if( door == DoorEnum.hood ){
        url = Uri.parse('$apiUrl/hood');
      }else{
        url = Uri.parse('$apiUrl/all');
      }

      final prefs = await SharedPreferences.getInstance();
      String? deviceUUID = prefs.getString('device_uuid');

      print(url);

      // Faites une requête PATCH ou POST avec le corps en JSON
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "source": deviceUUID ?? "frontend", // add device uuid to avoid autorefresh
          "Authorization": "Bearer $token" // Ajouter le token ici
        },// En-tête pour indiquer que le corps est en JSON
      );

      if (response.statusCode == 200) {
        // Décodez la réponse JSON en tant que Map, car nous attendons un objet Car
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return Car.fromEntity(CarEntity.fromJson(jsonResponse["data"]));//todo ne met pas a jour le car puisque MQTT envoie une notification de changement
      } else {
        throw Exception('Failed to update door $door state');
      }
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }
}