import 'package:bloc/bloc.dart';
import 'package:breach/core/error/failure.dart';
import 'package:breach/features/home/domain/use_cases/home_use_case.dart';
import 'package:equatable/equatable.dart';

part 'save_interests_state.dart';


class SaveInterestsCubit extends Cubit<SaveInterestsState> {

  SaveInterestsCubit(this.homeUseCase) : super(SaveInterestsInitial());
  final HomeUseCase homeUseCase;


  final List<String> _selectedIds = [];

  List<String> get selectedIds => List.unmodifiable(_selectedIds);

  void toggleInterest(String id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
    emit(SaveInterestsSelectionChanged(List.from(_selectedIds)));
  }



  Future<void> saveInterests() async {
    emit(SaveInterestsLoading());
    final result = await homeUseCase.saveUserInterests(_selectedIds);
    result.fold(
          (failure) => emit(SaveInterestsError(failure)),
          (_) => emit(SaveInterestsSuccess(List.unmodifiable(_selectedIds))),
    );
  }
}
