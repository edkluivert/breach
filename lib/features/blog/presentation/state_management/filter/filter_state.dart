import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class FilterState extends Equatable {

  const FilterState(this.selectedId);
  final String? selectedId;

  @override
  List<Object?> get props => [selectedId];
}


