import 'package:bloc/bloc.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:breach/features/home/domain/use_cases/home_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'posts_state.dart';

@LazySingleton()
class PostsCubit extends Cubit<PostsState> {

  PostsCubit(this.useCase) : super(PostsInitial());
  final HomeUseCase useCase;

  Future<void> loadPosts({String? category}) async {
    emit(PostsLoading());
    final result = await useCase.getPosts(category);
    result.fold(
          (failure) => emit(PostsError(failure.errorMessage)),
          (posts) => emit(PostsLoaded(posts)),
    );
  }
}
