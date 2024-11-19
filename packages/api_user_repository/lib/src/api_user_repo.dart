import 'dart:developer';

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
  Future<MyUser> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}