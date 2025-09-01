import 'package:breach/features/authentication/domain/use_cases/auth_use_case.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_formz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this.authUseCase) : super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpFormSubmitted>(_onSubmitted);
  }
  final AuthUseCase authUseCase;

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
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

  void _onPasswordChanged(SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    final password = Password.dirty(event.password);
    final confirmPassword =
    ConfirmPassword.dirty(password: password.value, value: state.confirmPassword.value);

    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: Formz.validate([state.email, password, confirmPassword]),
        status: state.status == FormzSubmissionStatus.inProgress
            ? state.status
            : FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onConfirmPasswordChanged(
      SignUpConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    final confirmPassword =
    ConfirmPassword.dirty(password: state.password.value, value: event.password);

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([state.email, state.password, confirmPassword]),
        status: state.status == FormzSubmissionStatus.inProgress
            ? state.status
            : FormzSubmissionStatus.initial,
      ),
    );
  }


  Future<void> _onSubmitted(
      SignUpFormSubmitted event, Emitter<SignUpState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {

          final result = await authUseCase.register(
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
