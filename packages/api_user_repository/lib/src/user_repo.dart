import 'package:api_user_repository/api_user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserRepository{
  final _secureStorage = const FlutterSecureStorage();

  Future<String?> getJwtToken();

  Future<MyUser> signUp(MyUser myUser,String password);

  Future<MyUser> signIn(String email,String password);

  Future<MyUser> getUser();

  Future<void> logOut();

}