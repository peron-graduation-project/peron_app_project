import 'package:equatable/equatable.dart';

enum RateStatus {
  initial,
  addRate,
  addedRate,
  deleteRate,
  deletedRate,
  // success,
  failure,
}

class RateState extends Equatable {
  final RateStatus status;
  final String? errorMessage;
  final String? deletedMessage;
  final String? rateId;
  final int? stars;

  const RateState({
    required this.status,
    this.errorMessage,
    this.rateId,
    this.stars,
    this.deletedMessage,
  });

  RateState copyWith({
    RateStatus? status,
    String? errorMessage,
    String? deletedMessage,
    String? rateId,
    int? stars,
  }) {
    return RateState(
      status: status ?? this.status,
      stars: stars ?? this.stars,
      errorMessage: errorMessage ?? this.errorMessage,
      deletedMessage: deletedMessage ?? this.deletedMessage,
      rateId: rateId ?? this.rateId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    rateId,
    deletedMessage,
    stars,
  ];
}
