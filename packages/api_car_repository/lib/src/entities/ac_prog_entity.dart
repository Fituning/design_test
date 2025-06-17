
import 'package:api_car_repository/src/enums/enum.dart';

class ACProgEntity {
  String id;
  String name;
  bool isActive;
  double temperature;
  VentilationLevelEnum ventilationLevel;
  DateTime dateInitial;
  DateTime dateFinal;
  List<DaysOfWeekEnum> repetition;

  ACProgEntity({
    required this.id,
    required this.name,
    required this.temperature,
    required this.ventilationLevel,
    required this.isActive,
    required this.dateInitial,
    required this.dateFinal,
    required this.repetition,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'temperature': temperature,
      'ventilation_level': ventilationLevel.index,
      'is_active': isActive,
      'date_initial': dateInitial,
      'date_final': dateFinal,
      'repetition': repetition,
    };
  }

  factory ACProgEntity.fromJson(Map<String, dynamic> json) {
    return ACProgEntity(
      id: json['_id'],
      name: json['name'],
      temperature: json['temperature'] as double,
      ventilationLevel: VentilationLevelEnumExtension.fromInt(json['ventilation_level']),
      isActive: json['is_active'],
      dateInitial: DateTime.parse(json['date_initial'] as String),
      dateFinal: DateTime.parse(json['date_final'] as String),
      repetition: (json['repetition'] as List)
          .map((repetitionJson) {
        return DaysOfWeekEnumExtension.fromString(repetitionJson as String);
      }).toList(),
    );
  }
}

