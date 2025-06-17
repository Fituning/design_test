import 'dart:async';

import 'package:api_user_repository/api_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiUserRepo apiUserRepo;
  late final StreamSubscription<MyUser?> _userSubscription;

  AuthBloc(this.apiUserRepo) : super(const AuthState.unknown()) {
    _userSubscription = apiUserRepo.user.listen((user) {
      add(AuthUserChanged(user));
    });

    // Gestion des événements
    on<AuthStarted>((event, emit) async {
      try {
        // Tenter de récupérer l'utilisateur connecté
        await apiUserRepo.getUser();
      } catch (e) {
        // Si la récupération échoue, émettre une déconnexion
        emit(const AuthState.unauthenticated());
        return;
      }
    });

    on<AuthUserChanged>((event, emit) {
      if(event.user != null){
        if(event.user!.cars.isEmpty){
          emit(AuthState.noCars(event.user!));
        }else if(event.user?.preferences.selectedCar == null ){
          emit(AuthState.noCarSelected(event.user!));
        }else{
          emit(AuthState.authenticated(event.user!));
        }

      } else {
        emit(const AuthState.unauthenticated());
      }
    });

  }
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

}
