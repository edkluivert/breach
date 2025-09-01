part of 'user_interests_cubit.dart';

abstract class UserInterestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInterestsInitial extends UserInterestsState {}

class UserInterestsLoading extends UserInterestsState {}

class UserInterestsError extends UserInterestsState {
  UserInterestsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class UserInterestsLoaded extends UserInterestsState {
  UserInterestsLoaded(this.interests);
  final List<InterestEntity> interests;

  @override
  List<Object?> get props => [interests];
}
