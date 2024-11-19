import 'package:api_user_repository/api_user_repository.dart';

abstract class UserRepository{

  Future<MyUser> signUp(MyUser myUser,String password);

  Future<MyUser> signIn(String email,String password);

  Future<void> logOut();
}