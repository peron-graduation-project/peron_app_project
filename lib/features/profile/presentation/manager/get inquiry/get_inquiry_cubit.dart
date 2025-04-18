import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/profile/data/models/inquiry_model.dart';
import 'package:peron_project/features/profile/domain/repos/get%20inquiry/get_inquiry_repo.dart';
import 'package:peron_project/features/profile/presentation/manager/get%20inquiry/get_inquiry_state.dart';
import '../../../../../core/error/failure.dart';


class GetInquiryCubit extends Cubit<GetInquiryState> {
  final GetInquiryRepo getInquiryRepo;

  GetInquiryCubit(this.getInquiryRepo) : super(GetInquiryStateInitial());

  Future<void> getInquires() async {
    emit(GetInquiryStateLoading());

    final Either<Failure, List<InquiryModel>> result = await getInquiryRepo.getInquiry();

    result.fold(
          (failure) {
        emit(GetInquiryStateFailure(errorMessage: failure.errorMessage));
      },
          (inquires) {
        print("✅✅✅ [DEBUG] inquires (in Cubit, before emit): $inquires");
        if (inquires.isNotEmpty) {
          print("✅✅✅ [DEBUG] First inquiry Type: ${inquires.first.runtimeType}");
          print("✅✅✅ [DEBUG] First inquiry: ${inquires.first.toJson()}");
        }
        emit(GetInquiryStateSuccess(inquires: inquires));
      },
    );
  }
}