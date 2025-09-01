part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);
  final String email;

  @override
  List<Object?> get props => [email];
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);
  final String password;

  @override
  List<Object?> get props => [password];
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  const SignUpConfirmPasswordChanged(this.password);
  final String password;


  @override
  List<Object?> get props => [password];
}

class SignUpFormSubmitted extends SignUpEvent {
  const SignUpFormSubmitted();


  @override
  List<Object?> get props => [];
}
