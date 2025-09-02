import 'package:bloc/bloc.dart';
import 'package:breach/features/home/domain/use_cases/home_use_case.dart';
import 'package:equatable/equatable.dart';

part 'save_interests_state.dart';

class SaveInterestsCubit extends Cubit<SaveInterestsState> {
  SaveInterestsCubit(this.homeUseCase) : super(SaveInterestsInitial());

  final HomeUseCase homeUseCase;

  final List<String> _selectedIds = [];


  final List<String> _initialIds = [];

  List<String> get selectedIds => List.unmodifiable(_selectedIds);


  void toggleInterest(String id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.removeWhere((e) => e == id);
    } else {
      _selectedIds.add(id);
    }


    final uniqueIds = _selectedIds.toSet().toList();
    _selectedIds
      ..clear()
      ..addAll(uniqueIds);

    emit(SaveInterestsSelectionChanged(List.from(_selectedIds)));
  }


  void setInitialSelectedIds(List<String> ids) {
    _initialIds
      ..clear()
      ..addAll(ids.toSet());

    _selectedIds
      ..clear()
      ..addAll(ids.toSet());

    emit(SaveInterestsSelectionChanged(List.from(_selectedIds)));
  }


  Future<void> saveInterests() async {
    emit(SaveInterestsLoading());
    final newIds = _selectedIds.where((id) => !_initialIds.contains(id)).toList();
    if (newIds.isEmpty) {
      emit(SaveInterestsSuccess(List.unmodifiable(_selectedIds)));
      return;
    }
    final result = await homeUseCase.saveUserInterests(newIds);
    result.fold(
          (failure) => emit(SaveInterestsError(failure.errorMessage)),
          (_) {
        _initialIds.addAll(newIds);
        emit(SaveInterestsSuccess(List.unmodifiable(_selectedIds)));
      },
    );
  }
}
