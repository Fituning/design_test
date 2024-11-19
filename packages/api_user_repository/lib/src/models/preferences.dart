


import 'package:flutter/material.dart';

import '../../api_user_repository.dart';

class Preferences{
  ThemeMode theme;
  NotificationModeEnum noltifications;
  String language;
  String? selectedCar;

  Preferences({
    required this.theme,
    required this.noltifications,
    required this.language,
    required this.selectedCar,
  });

  PreferencesEntity toEntity(){
    return PreferencesEntity(
        theme: theme,
        noltifications: noltifications,
        language: language,
        selectedCar: selectedCar,
    );
  }

  static Preferences fromEntity(PreferencesEntity entity){
    return Preferences(
        theme: entity.theme,
        noltifications: entity.noltifications,
        language: entity.language,
        selectedCar: entity.selectedCar,
    );
  }

}