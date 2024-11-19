import 'package:api_user_repository/api_user_repository.dart';
import 'package:api_car_repository/api_car_repository.dart';

class MyUser{
  String email;
  String firstName;
  String lastName;
  UserRoleEnum role;
  List<String> cars;
  Preferences preferences;

  MyUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.cars,
    required this.preferences,
  });

  MyUserEntity toEntity(){
    return MyUserEntity(
        email: email,
        firstName: firstName,
        lastName: lastName,
        role: role,
        cars: cars,
        preferences: preferences,
    );
  }

  static MyUser fromEntity(MyUserEntity entity){
    return MyUser(
        email: entity.email,
        firstName: entity.firstName,
        lastName: entity.lastName,
        role: entity.role,
        cars: entity.cars,
        preferences: entity.preferences,
    );
  }
}
