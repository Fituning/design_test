enum DoorStatusEnum {
  open,
  close,
}

enum DoorEnum {
  right,
  left,
  hood,
  all
}

extension DoorStatusEnumExtension on DoorStatusEnum {
  static DoorStatusEnum fromString(String state) {
    switch (state) {
      case 'open':
        return DoorStatusEnum.open;
      case 'close':
        return DoorStatusEnum.close;
      default:
        throw Exception('Invalid door state: $state');
    }
  }
}
