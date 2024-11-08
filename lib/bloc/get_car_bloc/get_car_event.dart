part of 'get_car_bloc.dart';

sealed class GetCarEvent extends Equatable {
  const GetCarEvent();

  @override
  List<Object?> get props => [];
}

class GetCar extends GetCarEvent {}

class UpdateAirConditioning extends GetCarEvent {
  final int? temperature;
  final AirConditioningModeEnum? mode;
  final VentilationLevelEnum? ventilationLevel;
  final bool? acIsActive;
  final bool? frontDefogging;
  final bool? backDefogging;

  UpdateAirConditioning({
    this.temperature,
    this.mode,
    this.ventilationLevel,
    this.acIsActive,
    this.frontDefogging,
    this.backDefogging,
  });

  @override
  List<Object?> get props => [temperature, mode,ventilationLevel, acIsActive, frontDefogging, backDefogging];
}


