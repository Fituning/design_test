import 'dart:convert';

import 'package:api_car_repository/api_car_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_car_event.dart';
part 'get_car_state.dart';

class GetCarBloc extends Bloc<GetCarEvent, GetCarState> {
  final ApiCarRepo _apiCarRepo;
  List<Car>? _cachedCars; // Variable pour stocker l'objet Car mis en cache

  GetCarBloc(this._apiCarRepo) : super(GetCarInitial()) {
    on<GetCars>((event, emit) async {
      print("in get car");
      _cachedCars = await _loadCachedCars();
      if (state is! GetCarSuccess) {
        emit(GetCarLoading());
      }
      try {
        List<Car> cars = await _apiCarRepo.getCars();// Sauvegarde les nouvelles données dans le cache
        _cachedCars = cars;
        _saveCarsToCache(cars);
        emit(GetCarSuccess(cars));
      } catch (e) {
        if (e is Exception) {
          emit(GetCarFailure(e.toString().replaceFirst('Exception: ', ''))); // Supprime le préfixe
        } else {
          emit(GetCarFailure('Une erreur inconnue s\'est produite.'));
        }
      }
    });

  }


  // Méthode pour charger une List<Car> depuis le cache
  Future<List<Car>?> _loadCachedCars() async {
    final prefs = await SharedPreferences.getInstance();
    final String? carsJson = prefs.getString('cachedCars');

    if (carsJson != null) {
      // Décoder la chaîne JSON en une liste dynamique
      final List<dynamic> carsData = jsonDecode(carsJson);

      // Convertir chaque élément JSON en un objet Car
      return carsData.map((carData) => Car.fromEntity(CarEntity.fromJson(carData))).toList();
    }

    // Retourner une liste vide si rien n'est trouvé dans le cache
    return null;
  }


  // Méthode pour sauvegarder une List<Car> dans le cache
  Future<void> _saveCarsToCache(List<Car> cars) async {
    final prefs = await SharedPreferences.getInstance();

    // Convertir chaque Car en JSON et créer une liste de JSON
    final carsJsonList = cars.map((car) => car.toEntity().toJson()).toList();

    // Sauvegarder la liste encodée en JSON dans le cache
    prefs.setString('cachedCars', jsonEncode(carsJsonList));
  }

}
