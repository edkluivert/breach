import 'package:breach/core/error/failure.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:breach/features/home/domain/entities/category_entity.dart';
import 'package:breach/features/home/domain/entities/interest_entity.dart';
import 'package:breach/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HomeUseCase {

  HomeUseCase(this.repo);
  final HomeRepo repo;

  Future<Either<Failure, List<BlogEntity>>> getPosts(String? category) {
    return repo.getPosts(category);
  }

  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    return repo.getCategories();
  }

  Future<Either<Failure, List<InterestEntity>>> getUserInterests() {
    return repo.getUserInterests();
  }

  Future<Either<Failure, bool>> saveUserInterests(List<String> ids) {
    return repo.saveUserInterests(ids);
  }
}
