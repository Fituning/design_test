import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:api_user_repository/api_user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUserRepo implements UserRepository{
  final String apiUrl = dotenv.env["API_KEY"]! + '/api/auth';
  final _secureStorage = const FlutterSecureStorage();
  final StreamController<MyUser?> _userController = StreamController<MyUser?>.broadcast();

  ApiUserRepo();

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final url = Uri.parse('$apiUrl/login');

      final Map<String, dynamic> body = {
        'email' : email,
        'password' : password,
      };

      final jsonBody = jsonEncode(body);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"}, // En-tête pour indiquer que le corps est en JSON
        body: jsonBody,
      );

      if(response.statusCode == 200){
        Map<String,dynamic> jsonResponse = jsonDecode(response.body);

        String token = jsonResponse['data']['token'];
        await _secureStorage.write(key: 'jwt_token', value: token);

        // return MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]["user"]));
        final user =  MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]["user"]));
        // Diffuser l'utilisateur dans le Stream
        _userController.add(user);
      }else{
        _userController.add(null);
        throw Exception(jsonDecode(response.body)["error"]);
      }

    } catch (e) {
      log(e.toString());
      _userController.add(null);
      rethrow;
    }
  }

  @override
  Future<void> signUp(String email, String password, String firstName, String lastName) async {
    try {
      final url = Uri.parse('$apiUrl/signup');

      final Map<String, dynamic> body = {
        'email' : email,
        'password' : password,
        'first_name' : firstName,
        'last_name' : lastName
      };

      final jsonBody = jsonEncode(body);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"}, // En-tête pour indiquer que le corps est en JSON
        body: jsonBody,
      );

      if(response.statusCode == 200){
        Map<String,dynamic> jsonResponse = jsonDecode(response.body);

        //implement JWT token registration
        String token = jsonResponse['data']['token'];
        await _secureStorage.write(key: 'jwt_token', value: token);

        final user =  MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]["user"]));
        // Diffuser l'utilisateur dans le Stream
        _userController.add(user);
      }else{
        _userController.add(null);
        throw Exception(response.body);
      }

    } catch (e) {
      log(e.toString());
      _userController.add(null);
      rethrow;
    }
  }

  @override
  Future<String> getJwtToken() async {
    // _secureStorage.delete(key: 'jwt_token'); // todo to remove (for disconnect)
    String? token = await _secureStorage.read(key: 'jwt_token');

    if (token == null) {
      throw Exception("Token not found");
    }

    try {
      final response = await http.get(
        Uri.parse('$apiUrl/validate_token'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        await getUser(); //todo a voir si on laisse, peut être utiliser MQTT
        return token;
      } else {
        _userController.add(null); // Appeler la callback si le token est expiré
        throw Exception("Token expired");
      }
    } catch (e) {
      _userController.add(null); // Appeler la callback pour notifier l'expiration
      throw Exception("Failed to validate token: $e");
    }
  }


  // Getter pour exposer le Stream
  Stream<MyUser?> get user => _userController.stream;

  @override
  Future<void> getUser() async {
    try {
      final url = Uri.parse('$apiUrl/user');

      // Lire le token JWT depuis le stockage sécurisé
      String? token = await _secureStorage.read(key: 'jwt_token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token" // Ajouter le token ici
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Récupérer l'utilisateur depuis la réponse
        final user =  MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]));
        // Diffuser l'utilisateur dans le Stream
        _userController.add(user);
      } else {
        _userController.add(null);
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      // Diffuser un utilisateur vide en cas d'erreur
      _userController.add(null);
      rethrow;
    }
  }

  selectCar(String carId) {}//todo

  addCar(String vin) async {
    try {
      final url = Uri.parse('$apiUrl/add_car');

      // Lire le token JWT depuis le stockage sécurisé
      String? token = await _secureStorage.read(key: 'jwt_token');

      final Map<String, dynamic> body = {
        'vin' : vin,
      };

      final jsonBody = jsonEncode(body);

      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Ajouter le token ici
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Récupérer l'utilisateur depuis la réponse
        final user =  MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]));
        // Diffuser l'utilisateur dans le Stream
        _userController.add(user);
      } else {
        _userController.add(null);
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      // Diffuser un utilisateur vide en cas d'erreur
      _userController.add(null);
      rethrow;
    }
  }

}