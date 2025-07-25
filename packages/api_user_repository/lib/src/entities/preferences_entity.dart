
import 'package:flutter/material.dart';
import 'package:api_user_repository/src/enums/enums.dart';

class PreferencesEntity{
  ThemeMode theme;
  NotificationModeEnum noltifications;
  String language;
  String? selectedCar; //selected car id

  PreferencesEntity({
    required this.theme,
    required this.noltifications,
    required this.language,
    required this.selectedCar,
  });

  Map<String,dynamic> toJson(){
    return{
      'theme': theme,
      'notifications': noltifications,
      'language': language,
      'selected_car': selectedCar,
    };
  }

  static PreferencesEntity fromJson(Map<String,dynamic> json){
    return PreferencesEntity(
        theme: themeModeFromString(json['theme']) ,//todo method to convert in Theme mode
        noltifications: NotificationModeEnumExtension.fromString(json['notifications']),
        language: json['language'] as String,
        selectedCar: json['selected_car'] as String?,
    );
  }

  static ThemeMode themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

}