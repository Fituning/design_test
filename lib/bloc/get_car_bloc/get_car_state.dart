part of 'get_car_bloc.dart';

sealed class GetCarState extends Equatable {
  const GetCarState();
  @override
  List<Object> get props => [];
}

final class GetCarInitial extends GetCarState {}
final class GetCarFailure extends GetCarState {}
final class GetCarLoading extends GetCarState {}
final class GetCarReLoadFailure extends GetCarState {
  final Car car;

  const GetCarReLoadFailure(this.car);

  @override
  List<Object> get props => [car];
}
final class GetCarSuccess extends GetCarState {
  final Car car;

  const GetCarSuccess(this.car);

  @override
  List<Object> get props => [car];
}