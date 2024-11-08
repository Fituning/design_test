import 'package:api_car_repository/api_car_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final ApiCarRepo _apiCarRepo;
  Car? _cachedCar; // Variable pour stocker l'objet Car mis en cache

  CarBloc(this._apiCarRepo) : super(GetCarInitial()) {
    on<GetCar>((event, emit) async {
      // Si l'état actuel n'est ni GetCarSuccess ni GetCarReLoadFailure, émettre GetCarLoading
      if (state is! GetCarSuccess && state is! GetCarReLoadFailure) {
        emit(GetCarLoading());
      }

      try {
        // Simuler une erreur pour tester l'état GetCarReLoadFailure
        // if (state is GetCarSuccess) {
        //   throw Exception("Simulated error");
        // }

        // Faire la requête pour obtenir les données de la voiture
        Car car = await _apiCarRepo.getCar();
        _cachedCar = car; // Mettre à jour le cache avec les nouvelles données
        emit(GetCarSuccess(car));
      } catch (e) {
        // Si l'état précédent est GetCarSuccess, émettre GetCarReLoadFailure
        if (_cachedCar != null) {
          emit(GetCarReLoadFailure(_cachedCar!)); // Utilisez _cachedCar pour afficher les anciennes données
        } else {
          _cachedCar = null;
          emit(GetCarFailure());
        }
      }
    });

    on<UpdateAirConditioning>((event, emit) async {
      try {
        // Appel à l'API pour changer la température de la climatisation
        Car updatedCar = await _apiCarRepo.updateAirConditioning(
            temperature:  event.temperature,
            ventilationLevel : event.ventilationLevel,
            mode: event.mode,
            acIsActive: event.acIsActive,
            frontDefogging: event.frontDefogging,
            backDefogging: event.backDefogging
        );
        _cachedCar = updatedCar; // Mettre à jour le cache
        emit(GetCarSuccess(updatedCar));
      } catch (e) {
        emit(GetCarFailure());
      }
    });

  }

  // Méthode pour obtenir l'objet Car mis en cache
  Car? get cachedCar => _cachedCar;

}
