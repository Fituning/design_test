import 'package:api_car_repository/api_car_repository.dart';

import '../../api_user_repository.dart';

class MyUserEntity{
  String email;
  String firstName;
  String lastName;
  UserRoleEnum role;
  List<Car> cars;
  Preferences preferences;

  MyUserEntity({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.cars,
    required this.preferences,
  });

  Map<String,dynamic> toJson(){
    return{
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'cars': cars,
      'preferences': preferences,
    };
  }

  static MyUserEntity fromJson(Map<String, dynamic> json) {
    return MyUserEntity(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      role: UserRoleEnumExtension.fromString(json['role']),
      cars: (json['cars'] as List)
          .map((carJson) => Car.fromEntity(CarEntity.fromJson(carJson as Map<String, dynamic>)))
          .toList(),
      preferences: Preferences.fromEntity(PreferencesEntity.fromJson(json['preferences'] as Map<String,dynamic>)),
    );
  }


}