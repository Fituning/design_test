enum SoftwareStatusEnum {
  up_to_date,
  to_update,
  end_of_life,
  obsolete,
  deprecated,
  maintenance,
  vulnerable,
}

extension SoftwareStatusEnumExtension on SoftwareStatusEnum {
  static SoftwareStatusEnum fromString(String status) {
    switch (status) {
      case 'up_to_date':
        return SoftwareStatusEnum.up_to_date;
      case 'to_update':
        return SoftwareStatusEnum.to_update;
      case 'end_of_life':
        return SoftwareStatusEnum.end_of_life;
      case 'obsolete':
        return SoftwareStatusEnum.obsolete;
      case 'deprecated':
        return SoftwareStatusEnum.deprecated;
      case 'maintenance':
        return SoftwareStatusEnum.maintenance;
      case 'vulnerable':
        return SoftwareStatusEnum.vulnerable;
      default:
        throw Exception('Invalid software status: $status');
    }
  }
}
