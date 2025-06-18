import 'package:equatable/equatable.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate.dart';

enum ReviewStatus { initial, loading, success, failure }

class ReviewState extends Equatable {
  final ReviewStatus status;
  final String? errorMessage;
  final List<Rate> rates;

  const ReviewState({
    required this.status,
    this.errorMessage,
    this.rates = const [],
  });

  ReviewState copyWith({
    ReviewStatus? status,
    String? errorMessage,
    List<Rate>? rates,
  }) {
    return ReviewState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      rates: rates ?? this.rates,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, rates];
}
