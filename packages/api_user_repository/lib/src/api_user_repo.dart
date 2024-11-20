import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:api_user_repository/api_user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUserRepo implements UserRepository{
  final String apiUrl = dotenv.env["API_KEY"]! + '/api/auth';
  final Function? onTokenExpired; // Callback pour gérer l'expiration du token
  final _secureStorage = const FlutterSecureStorage();

  ApiUserRepo({this.onTokenExpired});

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signIn(String email, String password) async {
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

        return MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]["user"]));
      }else{
        throw Exception(response.body);
      }

    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      final url = Uri.parse('$apiUrl/signup');

      final Map<String, dynamic> body = {
        'email' : myUser.email,
        'password' : password,
        'first_name' : myUser.firstName,
        'last_name' : myUser.lastName
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

        return MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]["user"]));
      }else{
        throw Exception(response.body);
      }

    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> getJwtToken() async {
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
        return token;
      } else {
        onTokenExpired!(); // Appeler la callback si le token est expiré
        throw Exception("Token expired");
      }
    } catch (e) {
      onTokenExpired!(); // Appeler la callback pour notifier l'expiration
      throw Exception("Failed to validate token: $e");
    }
  }


  @override
  Future<MyUser> getUser() async {
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
        return MyUser.fromEntity(MyUserEntity.fromJson(jsonResponse["data"]));
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}