
abstract class SortState {}

class SortStateInitial extends SortState {
  final String selectedSort;

  SortStateInitial({this.selectedSort = "الأكثر تقييما"});
}

class SortStateUpdated extends SortState {
  final String selectedSort;

  SortStateUpdated({required this.selectedSort});
}
