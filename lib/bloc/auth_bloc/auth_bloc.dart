import 'package:api_user_repository/api_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiUserRepo _apiUserRepo;

  AuthBloc(this._apiUserRepo) : super(const AuthState.unknown()) {
    on<GetUser>((event, emit) async {
      await _apiUserRepo.signIn("user1@gmail.com", "admin1234");
      try{
        MyUser user = await _apiUserRepo.getUser();
        emit(AuthState.authenticated(user));
      }catch (e) {
        emit(const AuthState.unauthenticated());
      }
    });

    on<TokenExpired>((event, emit) {
      emit(const AuthState.unauthenticated());
    });

  }
}
