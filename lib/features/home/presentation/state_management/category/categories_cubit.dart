import 'package:bloc/bloc.dart';
import 'package:breach/core/logger/app_logger.dart';
import 'package:breach/features/home/domain/entities/category_entity.dart';
import 'package:breach/features/home/domain/use_cases/home_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'categories_state.dart';

@LazySingleton()
class CategoriesCubit extends Cubit<CategoriesState> {

  CategoriesCubit(this.useCase) : super(CategoriesInitial());
  final HomeUseCase useCase;

  Future<void> loadCategories() async {

    emit(CategoriesLoading());
    final result = await useCase.getCategories();
    result.fold(
          (failure) => emit(CategoriesError(failure.errorMessage)),
          (categories) => emit(CategoriesLoaded(categories)),
    );
  }
}
