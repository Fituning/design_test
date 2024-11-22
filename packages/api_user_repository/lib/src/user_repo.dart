import 'package:api_user_repository/api_user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserRepository{
  final _secureStorage = const FlutterSecureStorage();

  Future<String?> getJwtToken();

  Future<void> signUp(String email, String password, String firstName, String lastName);

  Future<void> signIn(String email,String password);

  Future<void> getUser();

  Future<void> logOut();

}