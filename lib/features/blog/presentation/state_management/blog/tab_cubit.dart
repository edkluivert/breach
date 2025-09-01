
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class TabState extends Equatable {

  const TabState(this.selectedIndex);
  final int selectedIndex;

  @override
  List<Object?> get props => [selectedIndex];
}

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState(0));

  void updateIndex(int index) => emit(TabState(index));
}
