
enum UserRoleEnum {
  SUPER_ADMIN,
  ADMIN,
  MECHANIC,
  USER, // rôle virtuel géré par un middleware
}

extension UserRoleEnumExtension on UserRoleEnum {
  static UserRoleEnum fromString(String mode) {
    switch (mode) {
      case 'SUPER_ADMIN':
        return UserRoleEnum.SUPER_ADMIN;
      case 'ADMIN':
        return UserRoleEnum.ADMIN;
      case 'MECHANIC':
        return UserRoleEnum.MECHANIC;
      case 'USER':
        return UserRoleEnum.USER;
      default:
        throw Exception('Invalid User Role enum: $mode');
    }
  }
}
