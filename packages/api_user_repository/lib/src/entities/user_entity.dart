

import '../../api_user_repository.dart';

class MyUserEntity{
  String email;
  String firstName;
  String lastName;
  UserRoleEnum role;
  List<String> cars;
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
          .map((carJson) {
        if (carJson is Map<String, dynamic>) {
          // Si c'est un objet peuplé, on récupère uniquement l'_id
          return carJson['_id'] as String;
        } else if (carJson is String) {
          // Si c'est déjà une chaîne (ID), on la garde
          return carJson;
        } else {
          throw Exception("Type inattendu dans la liste 'cars': ${carJson.runtimeType}");
        }
      }).toList(),
      preferences: Preferences.fromEntity(PreferencesEntity.fromJson(json['preferences'] as Map<String,dynamic>)),
    );
  }


}