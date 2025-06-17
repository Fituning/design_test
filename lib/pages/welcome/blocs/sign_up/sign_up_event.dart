part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequired extends SignUpEvent{
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const SignUpRequired(this.email, this.password, this.firstName, this.lastName);

  @override
  List<Object?> get props => [email,password, firstName, lastName];
}

class SignOutRequired extends SignUpEvent{}