part of 'car_bloc.dart';

sealed class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object?> get props => [];
}

class GetCar extends CarEvent {}

class UpdateAirConditioning extends CarEvent {
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

// class UpdateCarFromMqtt extends CarEvent {}


