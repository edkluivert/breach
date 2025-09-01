import 'package:breach/core/error/failure.dart';
import 'package:breach/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';


@LazySingleton()
class AuthUseCase{

  AuthUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<Either<Failure, bool>> login(String email, String password){
    return authRepository.login(email: email, password: password);
  }

  Future<Either<Failure, bool>> register(String email, String password){
    return authRepository.register(email: email, password: password);
  }

}