import 'package:breach/features/app_bottom_nav/presentation/state_management/bottom_nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class AppBottomNavCubit extends Cubit<BottomNavState> {
  AppBottomNavCubit() : super(BottomNavState(0, 0));

  void changeTabIndex(int index) {
    emit(BottomNavState(index, state.barWidth));
  }

  void toggleWidth() {
    emit(BottomNavState(state.index, 20));

    Future<void>.delayed(const Duration(milliseconds: 300)).then((_) {
      emit(BottomNavState(state.index, 50));
    });
  }

  void reset(){
    emit(BottomNavState(0, 0));
  }

}
