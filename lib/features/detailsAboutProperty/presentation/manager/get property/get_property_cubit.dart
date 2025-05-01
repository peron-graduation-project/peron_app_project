import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_property_state.dart';

class GetPropertyCubit extends Cubit<GetPropertyState> {
  GetPropertyCubit() : super(GetPropertyInitial());
}
