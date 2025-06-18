import 'package:equatable/equatable.dart';

class Rate extends Equatable {
  final int ratingId;
  final String userName;
  final int? stars;
  final String comment;
  final String createdAt;
  final String timeAgo;

  const Rate({
    required this.ratingId,
    required this.userName,
    required this.stars,
    required this.comment,
    required this.createdAt,
    required this.timeAgo,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      ratingId: json['ratingId'] as int,
      userName: json['userName'] as String,
      stars: json['stars'],
      comment: json['comment'] as String,
      createdAt: json['createdAt'] as String,
      timeAgo: json['timeAgo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratingId': ratingId,
      'userName': userName,
      'stars': stars,
      'comment': comment,
      'createdAt': createdAt,
      'timeAgo': timeAgo,
    };
  }

  static List<Rate> fromJsonList(List<dynamic> list) {
    List<Rate> rates = [];
    for (var item in list) {
      rates.add(Rate.fromJson(item));
    }
    return rates;
  }

  @override
  List<Object?> get props => [
    ratingId,
    userName,
    stars,
    comment,
    createdAt,
    timeAgo,
  ];
}
