part of 'car_bloc.dart';

sealed class CarState extends Equatable {
  const CarState();
  @override
  List<Object> get props => [];
}

final class GetCarInitial extends CarState {}
final class GetCarFailure extends CarState {}
final class GetCarLoading extends CarState {}

abstract class CarLoadedState extends CarState {
  final Car car;

  const CarLoadedState(this.car);

  @override
  List<Object> get props => [car];
}

final class GetCarSuccess extends CarLoadedState {
  const GetCarSuccess(super.car);
}

final class GetCarReLoadFailure extends CarLoadedState {
  final String msg;

  const GetCarReLoadFailure(super.car, this.msg);

  @override
  List<Object> get props => super.props..add(msg);
}

final class UpdateCarFailure extends CarState {}
