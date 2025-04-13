class NotificationModel {
  final String id;
  final String userId;
  final String message;
  final String createdAt;
  final bool isRead;
  final Map<String, dynamic>? user;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.isRead,
    this.user,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      message: json['message'] ?? '',
      createdAt: json['createdAt'] ?? '',
      isRead: json['isRead'] ?? false,
      user: json['user'] as Map<String, dynamic>?,
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      userId: userId,
      message: message,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      user: user,
    );
  }
}