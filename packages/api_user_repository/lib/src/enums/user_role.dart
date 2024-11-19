enum UserRoleEnum {
  superAdmin,
  admin,
  moderator,
  user,
}

extension UserRoleEnumExtension on UserRoleEnum {
  static UserRoleEnum fromString(String mode) {
    switch (mode) {
      case 'super_admin':
        return UserRoleEnum.superAdmin;
      case 'admin':
        return UserRoleEnum.admin;
      case 'moderator':
        return UserRoleEnum.moderator;
      case 'user':
        return UserRoleEnum.user;
      default:
        throw Exception('Invalid air conditioning mode: $mode');
    }
  }
}
