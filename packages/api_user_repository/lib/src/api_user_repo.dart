import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:api_user_repository/api_user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUserRepo implements UserRepository{
  final String apiUrl = dotenv.env["API_KEY"]! + '/api/auth';

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

      print(response.body);

      if(response.statusCode == 200){
        Map<String,dynamic> jsonResponse = jsonDecode(response.body);
        // print(jsonResponse['data']['token']);
        // print(jsonResponse["data"]["user"]);
        //
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
  Future<MyUser> signUp(MyUser myUser, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}