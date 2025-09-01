part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesError extends CategoriesState {
  CategoriesError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded(this.categories);
  final List<CategoryEntity> categories;

  @override
  List<Object?> get props => [categories];
}
