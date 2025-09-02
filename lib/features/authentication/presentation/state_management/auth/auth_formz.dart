// email.dart
import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  static final _regex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  EmailValidationError? validator(String value) {
    return _regex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}



enum PasswordValidationLoginError { tooShort }

class PasswordLogin extends FormzInput<String, PasswordValidationLoginError> {
  const PasswordLogin.pure() : super.pure('');
  const PasswordLogin.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationLoginError? validator(String value) {
    return value.length >= 8 ? null : PasswordValidationLoginError.tooShort;
  }
}


enum PasswordValidationError { empty, short, noUpperCase, noLowerCase, noNumber, noSpecialChar }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 8) return PasswordValidationError.short;
    if (!_passwordRegExp.hasMatch(value)) {
      if (!RegExp('[A-Z]').hasMatch(value)) return PasswordValidationError.noUpperCase;
      if (!RegExp('[a-z]').hasMatch(value)) return PasswordValidationError.noLowerCase;
      if (!RegExp(r'\d').hasMatch(value)) return PasswordValidationError.noNumber;
      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return PasswordValidationError.noSpecialChar;
      }
    }
    return null;
  }
}


extension PasswordValidationErrorX on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Please enter a new password';
      case PasswordValidationError.short:
        return 'Password must be at least 8 characters long';
      case PasswordValidationError.noUpperCase:
        return 'Password must contain at least one uppercase letter';
      case PasswordValidationError.noLowerCase:
        return 'Password must contain at least one lowercase letter';
      case PasswordValidationError.noNumber:
        return 'Password must contain at least one number';
      case PasswordValidationError.noSpecialChar:
        return 'Password must contain at least one special character';
    }
  }
}



enum ConfirmPasswordValidationError { mismatch, empty }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordValidationError.empty;
    return password == value ? null : ConfirmPasswordValidationError.mismatch;
  }
}


extension ConfirmNewPasswordValidationErrorX on ConfirmPasswordValidationError {
  String text() {
    switch (this) {
      case ConfirmPasswordValidationError.empty:
        return 'Please confirm password';
      case ConfirmPasswordValidationError.mismatch:
        return 'Passwords do not match';
    }
  }
}

