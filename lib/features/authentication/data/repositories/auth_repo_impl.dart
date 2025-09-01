import 'package:breach/core/error/failure.dart';
import 'package:breach/features/authentication/data/data_sources/auth_data_source.dart';
import 'package:breach/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: AuthRepository)
class AuthRepoImpl implements AuthRepository {
  AuthRepoImpl(this.authDataSource);

  final AuthRemoteDataSource authDataSource;


  @override
  Future<Either<Failure, bool>> login(
      {required String email, required String password}) async {
    try {
      final result = await authDataSource.login(
          email: email, password: password);
      return Right(result);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> register(
      {required String email, required String password}) async {
    try {
      final result = await authDataSource.register(
          email: email, password: password);
      return Right(result);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

}