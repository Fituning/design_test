import 'package:api_user_repository/api_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_car_event.dart';
part 'select_car_state.dart';

class SelectCarBloc extends Bloc<SelectCarEvent, SelectCarState> {
  final ApiUserRepo _apiUserRepo;
  SelectCarBloc( this._apiUserRepo) : super(SelectCarInitial()) {
    on<SelectCar>((event, emit) async {
      emit(SelectCarLoading());
      try{
        await _apiUserRepo.selectCar(event.carId);
        emit(SelectCarSuccess());
      } catch (e) {
        if (e is Exception) {
          emit(SelectCarFailure(e.toString().replaceFirst('Exception: ', ''))); // Supprime le préfixe
        } else {
          emit(SelectCarFailure('Une erreur inconnue s\'est produite.'));
        }
      }
    });
    on<AddCar>((event, emit) async {
      emit(SelectCarLoading());
      try{
        await _apiUserRepo.addCar(event.vin);
        emit(SelectCarSuccess());
      } catch (e) {
        if (e is Exception) {
          emit(SelectCarFailure(e.toString().replaceFirst('Exception: ', ''))); // Supprime le préfixe
        } else {
          emit(SelectCarFailure('Une erreur inconnue s\'est produite.'));
        }
      }
    });
  }
}
