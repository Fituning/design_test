enum VentilationLevelEnum {
  OFF,
  LEVEL_1,
  LEVEL_2,
  LEVEL_3,
}

extension VentilationLevelEnumExtension on VentilationLevelEnum {
  static VentilationLevelEnum fromString(String level) {
    switch (level) {
      case 'OFF':
        return VentilationLevelEnum.OFF;
      case 'LEVEL_1':
        return VentilationLevelEnum.LEVEL_1;
      case 'LEVEL_2':
        return VentilationLevelEnum.LEVEL_2;
      case 'LEVEL_3':
        return VentilationLevelEnum.LEVEL_3;
      default:
        throw Exception('Invalid air conditioning mode: $level');
    }
  }

  static VentilationLevelEnum fromInt(int level) {
    switch (level) {
      case 0:
        return VentilationLevelEnum.OFF;
      case 1:
        return VentilationLevelEnum.LEVEL_1;
      case 2:
        return VentilationLevelEnum.LEVEL_2;
      case 3:
        return VentilationLevelEnum.LEVEL_3;
      default:
        throw Exception('Invalid ventilation level: $level');
    }
  }

  // Méthode pour convertir l'enum en un int
  int toInt() {
    switch (this) {
      case VentilationLevelEnum.OFF:
        return 0;
      case VentilationLevelEnum.OFF:
        return 1;
      case VentilationLevelEnum.OFF:
        return 2;
      case VentilationLevelEnum.OFF:
        return 3;
      default:
        throw Exception('Invalid VentilationLevelEnum value');
    }
  }
}

