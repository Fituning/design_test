import 'package:api_car_repository/api_car_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../mqtt_service.dart'; // Pour encoder et décoder JSON

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final ApiCarRepo _apiCarRepo;
  final MqttService _mqttService;
  Car? _cachedCar; // Variable pour stocker l'objet Car mis en cache

  CarBloc(this._apiCarRepo)
      : _mqttService = MqttService(), // Initialise le service MQTT
        super(GetCarInitial()) {
    _initializeMqtt(); // Démarre la connexion MQTT

    on<GetCar>((event, emit) async {

      _cachedCar = await _loadCachedCar();
      if (state is! GetCarSuccess && state is! GetCarReLoadFailure) {
        emit(GetCarLoading());
      }

      try {
        Car car = await _apiCarRepo.getCar();
        _cachedCar = car;
        _saveCarToCache(car); // Sauvegarde les nouvelles données dans le cache
        emit(GetCarSuccess(car));
      } catch (e) {
        if (_cachedCar != null) {
          emit(GetCarReLoadFailure(_cachedCar!, "Connexion impossible au serveur"));
        } else {
          emit(GetCarFailure());
        }
      }
    });

    on<UpdateAirConditioning>((event, emit) async {
      try {
        Car updatedCar = await _apiCarRepo.updateAirConditioning(
          temperature: event.temperature,
          ventilationLevel: event.ventilationLevel,
          mode: event.mode,
          acIsActive: event.acIsActive,
          frontDefogging: event.frontDefogging,
          backDefogging: event.backDefogging,
        );
        _cachedCar = updatedCar;
        _saveCarToCache(updatedCar); // Sauvegarde les nouvelles données dans le cache
        emit(GetCarSuccess(updatedCar));
      } catch (e) {
        if (_cachedCar != null) {
          emit(GetCarReLoadFailure(_cachedCar!,"impossible de mettre a jour les données"));
        } else {
          emit(GetCarFailure());
        }
      }
    });
  }

  void _initializeMqtt() {
    _mqttService.connect();
    _mqttService.listen((message) {
      // Traite le message MQTT et mets à jour l'état si nécessaire
      print('Message MQTT reçu : $message');
      // Parse le message et mets à jour l'état de la voiture
      add(GetCar());
    });
  }

  // Méthode pour charger l'objet Car depuis le cache
  Future<Car?> _loadCachedCar() async {
    final prefs = await SharedPreferences.getInstance();
    final String? carJson = prefs.getString('cachedCar');
    if (carJson != null) {
      // _cachedCar = Car.fromJson(jsonDecode(carJson)); // Convertir JSON en objet Car
      return _cachedCar = Car.fromEntity(CarEntity.fromJson(jsonDecode(carJson))); // Convertir JSON en objet Car
      // emit(GetCarSuccess(_cachedCar!));
    }
    return null;
  }

  // Méthode pour sauvegarder l'objet Car dans le cache
  Future<void> _saveCarToCache(Car car) async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.setString('cachedCar', jsonEncode(car.toJson())); // Convertir objet Car en JSON
    prefs.setString('cachedCar', jsonEncode(car.toEntity().toJson())); // Convertir objet Car en JSON
  }

  // Méthode pour obtenir l'objet Car mis en cache
  Car? get cachedCar => _cachedCar;

  // Déconnecte MQTT lorsque le bloc est fermé
  @override
  Future<void> close() {
    _mqttService.disconnect();
    return super.close();
  }
}
