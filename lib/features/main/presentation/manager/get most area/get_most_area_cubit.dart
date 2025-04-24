import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20most%20area/get_most_area_repo.dart';
import 'package:peron_project/features/main/presentation/manager/get%20most%20area/get_most_area_state.dart';
import '../../../../../core/error/failure.dart';


class GetMostAreaCubit extends Cubit<GetMostAreaState> {
  final GetMostAreaRepo getMostAreaRepo;

  GetMostAreaCubit(this.getMostAreaRepo) : super(GetMostAreaStateInitial());

  Future<void> getMostArea({int top=10}) async {
    emit(GetMostAreaStateLoading());

    final Either<Failure, List<RecommendedProperty>> result = await getMostAreaRepo.getMostAreaProperties(top: top);

    result.fold(
          (failure) {
        emit(GetMostAreaStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        print("✅✅✅ [DEBUG] properties (in Cubit, before emit): $properties");
        if (properties.isNotEmpty) {
          print("✅✅✅ [DEBUG] First properties Type: ${properties.first.runtimeType}");
          print("✅✅✅ [DEBUG] First properties: ${properties.first.toJson()}");
        }
        emit(GetMostAreaStateSuccess(properties: properties));
      },
    );
  }
}