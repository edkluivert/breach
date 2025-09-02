import 'package:flutter_bloc/flutter_bloc.dart';

class DismissPopCubit extends Cubit<bool> {
  DismissPopCubit() : super(false);

  void showDialogOnce() => emit(true);

  void reset() => emit(false);
}
