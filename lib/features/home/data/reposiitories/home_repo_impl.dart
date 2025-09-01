import 'package:breach/core/error/failure.dart';
import 'package:breach/features/home/data/data_sources/home_data_source.dart';
import 'package:breach/features/home/data/models/blog_model.dart';
import 'package:breach/features/home/data/models/category_model.dart';
import 'package:breach/features/home/data/models/interest_model.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:breach/features/home/domain/entities/category_entity.dart';
import 'package:breach/features/home/domain/entities/interest_entity.dart';
import 'package:breach/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo{
  HomeRepoImpl(this.homeRemoteDataSource);
  final HomeRemoteDataSource homeRemoteDataSource;

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final result = await homeRemoteDataSource.getCategories();
      final response = result
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(response);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogModel>>> getPosts(String? category)async {
    try {
      final result = await homeRemoteDataSource.getPosts(category);
      final response = result
          .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(response);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InterestModel>>> getUserInterests() async {
    try {
      final result = await homeRemoteDataSource.getUserInterests();
      final response = result
          .map((e) => InterestModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(response);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserInterests(List<String> id) async {
    try {
      final result = await homeRemoteDataSource.saveUserInterests(categoryIds: id);
      return Right(result);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

}