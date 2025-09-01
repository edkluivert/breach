part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsError extends PostsState {
  PostsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class PostsLoaded extends PostsState {
  PostsLoaded(this.posts);
  final List<BlogEntity> posts;

  @override
  List<Object?> get props => [posts];
}
