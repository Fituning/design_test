import 'dart:convert';
import 'dart:developer';
import 'package:api_car_repository/api_car_repository.dart';
import 'package:api_car_repository/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

abstract class ACProgRepository extends BaseRepository{
  ACProgRepository(super.apiUrl, super.apiUserRepo);

  Future<List<ACProg>> getAllProg();
  Future<List<ACProg>> getAllActiveProg();
}

class ACProgRepo extends ACProgRepository{

  ACProgRepo(super.apiUrl, super.apiUserRepo);

  @override
  Future<List<ACProg>> getAllProg() async {
    try {
      final token = await apiUserRepo.getJwtToken();
      final response = await http.get(
        Uri.parse(apiUrl),
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
            .map((carData) => ACProg.fromEntity(ACProgEntity.fromJson(carData)))
            .toList();

      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  @override
  Future<List<ACProg>> getAllActiveProg() async {
    try {
      final token = await apiUserRepo.getJwtToken();
      final response = await http.get(
        Uri.parse('$apiUrl/active'),
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
            .map((carData) => ACProg.fromEntity(ACProgEntity.fromJson(carData)))
            .toList();

      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}