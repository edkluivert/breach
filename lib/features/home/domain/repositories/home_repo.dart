import 'package:breach/core/error/failure.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:breach/features/home/domain/entities/category_entity.dart';
import 'package:breach/features/home/domain/entities/interest_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo{
  Future<Either<Failure, List<BlogEntity>>> getPosts(String? category);
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<InterestEntity>>> getUserInterests();
  Future<Either<Failure, bool>> saveUserInterests(List<String> id);
}