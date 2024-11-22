part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}


class GetUser extends AuthEvent{}
class AuthUserChanged extends AuthEvent{
  final MyUser? user;

  const AuthUserChanged(this.user);
}

class AuthStarted extends AuthEvent{}

class TokenExpired extends AuthEvent{}
