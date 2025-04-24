import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/main/presentation/manager/sort%20button/sort_button_state.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortStateInitial());

  void updateSort(String selectedSort) {
    emit(SortStateUpdated(selectedSort: selectedSort));
  }
}
