import 'package:breach/features/blog/presentation/state_management/filter/filter_state.dart';
import 'package:breach/features/features.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState(null));

  void select(String id) => emit(FilterState(id));
}