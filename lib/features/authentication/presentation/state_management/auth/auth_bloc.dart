import 'dart:async';

import 'package:breach/core/constants/local_data.dart';
import 'package:breach/core/local_data/first_time_user/get_first_time.dart';
import 'package:breach/core/local_data/user_token/get_user_logged_in_token.dart';
import 'package:breach/core/logger/app_logger.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_event.dart';
import 'package:breach/features/authentication/presentation/state_management/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc({
    required this.secureStorage,
  }) : super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final FlutterSecureStorage secureStorage;


  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = await secureStorage.read(key: loggedInUserToken);
    final getFirstTime = await secureStorage.read(key: firstTimeUser);
    if(getFirstTime == null || getFirstTime.isEmpty) {
      AppLogger.w('User is a first time user, redirecting to onboarding.');
      emit(const FirstTimer());
      return;
    }
    if (token != null && token.isNotEmpty) {
      emit(Authenticated(token));
    } else {
      AppLogger.wtf('User is not authenticated.');
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(const LogoutLoading());
    try {
      await secureStorage.delete(key: loggedInUserToken);
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
