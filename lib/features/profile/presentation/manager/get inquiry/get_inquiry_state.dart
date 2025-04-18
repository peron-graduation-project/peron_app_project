import 'package:equatable/equatable.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/profile/data/models/inquiry_model.dart';

abstract class GetInquiryState extends Equatable {
  const GetInquiryState();

  @override
  List<Object?> get props => [];
}

class GetInquiryStateInitial extends GetInquiryState {}

class GetInquiryStateLoading extends GetInquiryState {}

class GetInquiryStateSuccess extends GetInquiryState {
  final List<InquiryModel> inquires;

  const GetInquiryStateSuccess({required this.inquires});

  @override
  List<Object?> get props => [inquires];
}

class GetInquiryStateFailure extends GetInquiryState {
  final String errorMessage;

  const GetInquiryStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
