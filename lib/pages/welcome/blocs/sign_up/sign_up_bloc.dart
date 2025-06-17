import 'package:api_user_repository/api_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final ApiUserRepo _apiUserRepo;
  SignUpBloc(
      this._apiUserRepo
      ) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpLoading());
      try{
        await _apiUserRepo.signUp(event.email, event.password, event.firstName, event.lastName);
        emit(SignUpSuccess());
      } catch (e) {
        if (e is Exception) {
          emit(SignUpFailure(e.toString().replaceFirst('Exception: ', ''))); // Supprime le préfixe
        } else {
          emit(SignUpFailure('Une erreur inconnue s\'est produite.'));
        }
      }
    });
  }
}
