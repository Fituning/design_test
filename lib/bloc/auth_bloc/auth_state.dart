part of 'auth_bloc.dart';

enum Authenticationstatus { authenticated, unauthenticated, unknown, noCarSelected, noCars }

class AuthState extends Equatable {
  const AuthState._({
    this.status = Authenticationstatus.unknown,
    this.user,
  });

  final Authenticationstatus status;
  final MyUser? user;

  const AuthState.unknown() : this._();
  const AuthState.authenticated(MyUser myUser) : this._(status: Authenticationstatus.authenticated, user: myUser);
  const AuthState.unauthenticated() : this._(status: Authenticationstatus.unauthenticated);
  const AuthState.noCarSelected(MyUser myUser): this._(status: Authenticationstatus.noCarSelected);
  const AuthState.noCars(MyUser myUser): this._(status: Authenticationstatus.noCars);


  @override
  List<Object?> get props => [status,user];
}
