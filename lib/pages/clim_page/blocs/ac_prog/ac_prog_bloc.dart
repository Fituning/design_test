import 'package:api_car_repository/api_car_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ac_prog_event.dart';
part 'ac_prog_state.dart';

class AcProgBloc extends Bloc<AcProgEvent, AcProgState> {
  final ApiCarRepo _apiCarRepo;
  AcProgBloc(this._apiCarRepo) : super(AcProgInitial()) {
    on<GetAllProg>((event, emit) async {
      if (state is! AcProgSuccess) {
        emit(AcProgLoading());
      }
      try{
        List<ACProg> progs = await _apiCarRepo.acProgRepo.getAllProg();
        emit(AcProgSuccess(progs));
      }catch(e){
        emit(AcProgFailure());// todo add message error if necessary
      }
    });

    on<GetAllActiveProg>((event, emit) async {
      if (state is! AcProgSuccess) {
        emit(AcProgLoading());
      }
      try{
        List<ACProg> progs = await _apiCarRepo.acProgRepo.getAllActiveProg();
        emit(AcProgSuccess(progs));
      }catch(e){
        emit(AcProgFailure());// todo add message error if necessary
      }
    });
  }
}
