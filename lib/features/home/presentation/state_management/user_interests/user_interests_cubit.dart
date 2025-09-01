import 'package:bloc/bloc.dart';
import 'package:breach/core/local_data/user_data/secured_user_data.dart';
import 'package:breach/features/home/domain/entities/interest_entity.dart';
import 'package:breach/features/home/domain/use_cases/home_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'user_interests_state.dart';

@LazySingleton()
class UserInterestsCubit extends Cubit<UserInterestsState> {

  UserInterestsCubit(this.useCase,) : super(UserInterestsInitial());
  final HomeUseCase useCase;

  Future<void> loadUserInterests() async {
    emit(UserInterestsLoading());
    final result = await useCase.getUserInterests();
    result.fold(
          (failure) => emit(UserInterestsError(failure.errorMessage)),
          (interests){
            emit(UserInterestsLoaded(interests));
          },
    );
  }
}
