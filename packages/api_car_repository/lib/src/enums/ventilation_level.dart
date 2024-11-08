enum VentilationLevelEnum {
  off,
  level1,
  level2,
  level3,
}

extension VentilationLevelEnumExtension on VentilationLevelEnum {
  static VentilationLevelEnum fromInt(int level) {
    switch (level) {
      case 0:
        return VentilationLevelEnum.off;
      case 1:
        return VentilationLevelEnum.level1;
      case 2:
        return VentilationLevelEnum.level2;
      case 3:
        return VentilationLevelEnum.level3;
      default:
        throw Exception('Invalid ventilation level: $level');
    }
  }

  // Méthode pour convertir l'enum en un int
  int toInt() {
    switch (this) {
      case VentilationLevelEnum.off:
        return 0;
      case VentilationLevelEnum.level1:
        return 1;
      case VentilationLevelEnum.level2:
        return 2;
      case VentilationLevelEnum.level3:
        return 3;
      default:
        throw Exception('Invalid VentilationLevelEnum value');
    }
  }
}

