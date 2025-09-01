part of 'save_interests_cubit.dart';


abstract class SaveInterestsState extends Equatable {
  const SaveInterestsState();

  @override
  List<Object?> get props => [];
}

class SaveInterestsInitial extends SaveInterestsState {}

class SaveInterestsSelectionChanged extends SaveInterestsState {
  const SaveInterestsSelectionChanged(this.selectedIds);
  final List<String> selectedIds;

  @override
  List<Object?> get props => [selectedIds];
}

class SaveInterestsLoading extends SaveInterestsState {}

class SaveInterestsSuccess extends SaveInterestsState {
  const SaveInterestsSuccess(this.savedIds);
  final List<String> savedIds;

  @override
  List<Object?> get props => [savedIds];
}

class SaveInterestsError extends SaveInterestsState {
  const SaveInterestsError(this.failure);
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

