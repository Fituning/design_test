part of 'get_car_bloc.dart';

sealed class GetCarEvent extends Equatable {
  const GetCarEvent();

  @override
  List<Object?> get props => [];
}

class GetCars extends GetCarEvent {}