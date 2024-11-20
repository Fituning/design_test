part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class GetUser extends AuthEvent{}

class TokenExpired extends AuthEvent{}
