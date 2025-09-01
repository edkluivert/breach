import 'package:breach/features/authentication/domain/use_cases/auth_use_case.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_formz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authUseCase) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onSubmitted);
  }
  final AuthUseCase authUseCase;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
          email: email,
          isValid: Formz.validate([email, state.password]),
          status: state.status == FormzSubmissionStatus.inProgress
              ? state.status
              : FormzSubmissionStatus.initial),
    );
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = PasswordLogin.dirty(event.password);
    emit(
      state.copyWith(
          password: password,
          isValid: Formz.validate(
            [state.email, password],
          ),
          status: state.status == FormzSubmissionStatus.inProgress
              ? state.status
              : FormzSubmissionStatus.initial),
    );
  }

  Future<void> _onSubmitted(
      LoginFormSubmitted event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {

          final result = await authUseCase.login(
            state.email.value,
            state.password.value,
          );

          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  status: FormzSubmissionStatus.failure,
                  errorMessage: failure.errorMessage,
                ),
              );
            },
            (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
          );

      } catch (e) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
