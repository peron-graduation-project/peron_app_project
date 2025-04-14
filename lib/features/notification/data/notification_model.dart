class NotificationModel {
  final int id;
  final int? userId;
  final String message;
  final DateTime? createdAt;
  final User? user;

  NotificationModel({
    required this.id,
    this.userId,
    required this.message,
    this.createdAt,
    this.user,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print("✅✅✅ [DEBUG] Parsing JSON: $json");
    DateTime? parsedCreatedAt;
    try {
      parsedCreatedAt = DateTime.parse(json['createdAt']);
    } catch (e) {
      print("❌ [ERROR] Error parsing createdAt: $e, raw value: ${json['createdAt']}");
      parsedCreatedAt = null;
    }

    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      message: json['message'],
      createdAt: parsedCreatedAt,
      user: json['user'] == null ? null : User.fromJson(json['user']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'createdAt': createdAt?.toIso8601String(),
      'user': user?.toJson(),
    };
  }
}

class User {
  User();

  factory User.fromJson(Map<String, dynamic> json) {
    return User();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}