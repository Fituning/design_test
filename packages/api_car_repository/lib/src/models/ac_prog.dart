import 'package:api_car_repository/api_car_repository.dart';


class ACProg{
  String id;
  String name;
  int temperature;
  VentilationLevelEnum ventilationLevel;
  bool isActive;
  DateTime dateInitial;
  DateTime dateFinal;
  List<DaysOfWeekEnum> repetition;

  ACProg({
    required this.id,
    required this.name,
    required this.temperature,
    required this.ventilationLevel,
    required this.isActive,
    required this.dateInitial,
    required this.dateFinal,
    required this.repetition,
  });

  ACProgEntity toEntity(){
    return ACProgEntity(
        id: id,
        name: name,
        temperature: temperature,
        ventilationLevel: ventilationLevel,
        isActive: isActive,
        dateInitial: dateInitial,
        dateFinal: dateFinal,
        repetition: repetition,
    );
  }

  static ACProg fromEntity(ACProgEntity entity){
    return ACProg(
      id: entity.id,
      name: entity.name,
      temperature: entity.temperature,
      ventilationLevel: entity.ventilationLevel,
      isActive: entity.isActive,
      dateInitial: entity.dateInitial,
      dateFinal: entity.dateFinal,
      repetition: entity.repetition,
    );
  }


}