import 'package:api_user_repository/api_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ApiUserRepo _apiUserRepo;
  SignInBloc(
      this._apiUserRepo
      ) : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInLoading());
      try{
        await _apiUserRepo.signIn(event.email, event.password);
        emit(SignInSuccess());
      } catch (e) {
        if (e is Exception) {
          emit(SignInFailure(e.toString().replaceFirst('Exception: ', ''))); // Supprime le préfixe
        } else {
          emit(SignInFailure('Une erreur inconnue s\'est produite.'));
        }
      }
    });
    // on<SignOutRequired>((event,emit) async => await _apiUserRepo.logOut());
  }
}
