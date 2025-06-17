part of 'select_car_bloc.dart';

sealed class SelectCarState extends Equatable {
  const SelectCarState();
  @override
  List<Object> get props => [];
}

final class SelectCarInitial extends SelectCarState {}
class SelectCarFailure extends SelectCarState {
  final String error;

  const SelectCarFailure(this.error);

  @override
  List<Object> get props => [error];
}
class SelectCarLoading extends SelectCarState {}

class SelectCarSuccess extends SelectCarState {}
