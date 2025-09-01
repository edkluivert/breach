import 'package:breach/core/error/failure.dart';
import 'package:dartz/dartz.dart';


abstract class AuthRepository {
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> register({
    required String email,
    required String password,
  });

}
