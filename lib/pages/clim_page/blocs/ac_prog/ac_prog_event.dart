part of 'ac_prog_bloc.dart';

sealed class AcProgEvent extends Equatable {
  const AcProgEvent();

  @override
  List<Object?> get props => [];
}


class GetAllProg extends AcProgEvent{}

class GetAllActiveProg extends AcProgEvent{}