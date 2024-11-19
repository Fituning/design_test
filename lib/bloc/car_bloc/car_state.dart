part of 'car_bloc.dart';

sealed class CarState extends Equatable {
  const CarState();
  @override
  List<Object> get props => [];
}

final class GetCarInitial extends CarState {}
final class GetCarFailure extends CarState {}
final class GetCarLoading extends CarState {}

final class GetCarReLoadFailure extends CarState {
  final Car car;
  final String msg;

  const GetCarReLoadFailure(this.car,this.msg);

  @override
  List<Object> get props => [car,msg];
}

final class GetCarSuccess extends CarState {
  final Car car;

  const GetCarSuccess(this.car);

  @override
  List<Object> get props => [car];
}

final class UpdateCarFailure extends CarState {}
