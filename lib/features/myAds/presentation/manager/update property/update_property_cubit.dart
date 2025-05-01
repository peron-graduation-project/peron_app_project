import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_property_state.dart';

class UpdatePropertyCubit extends Cubit<UpdatePropertyState> {
  UpdatePropertyCubit() : super(UpdatePropertyInitial());
}
