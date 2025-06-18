import 'package:equatable/equatable.dart';

class RateParam extends Equatable {
  final int? propertyId;
  final int? stars;
  final String? comment;

  const RateParam({this.propertyId, this.stars, this.comment});

  @override
  List<Object?> get props => [propertyId, stars, comment];
}
