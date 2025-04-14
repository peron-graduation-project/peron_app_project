class NotificationModel {
  final int id;
  final String userId;
  final String message;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? '',
      message: json['message'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
