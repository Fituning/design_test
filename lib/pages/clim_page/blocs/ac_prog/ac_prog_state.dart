part of 'ac_prog_bloc.dart';

sealed class AcProgState extends Equatable {
  const AcProgState();
  @override
  List<Object> get props => [];
}

final class AcProgInitial extends AcProgState {}
final class AcProgLoading extends AcProgState {}
final class AcProgSuccess extends AcProgState {
  final List<ACProg> progs;

  const AcProgSuccess(this.progs);

  @override
  List<Object> get props => [progs];
}
final class AcProgFailure extends AcProgState {}
