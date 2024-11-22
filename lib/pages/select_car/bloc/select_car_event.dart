part of 'select_car_bloc.dart';

sealed class SelectCarEvent extends Equatable {
  const SelectCarEvent();

  @override
  List<Object?> get props => [];
}

class SelectCar extends SelectCarEvent{
  final String carId;

  const SelectCar(this.carId);

  @override
  List<Object?> get props => [carId];
}

class AddCar extends SelectCarEvent{
  final String vin;

  const AddCar(this.vin);

  @override
  List<Object?> get props => [vin];
}