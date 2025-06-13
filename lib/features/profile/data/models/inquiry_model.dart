
class InquiryModel {
  final int id;
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String message;
  final String? adminReply;
  final DateTime createdAt;
  final DateTime? repliedAt;

  InquiryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    this.adminReply,
    required this.createdAt,
    this.repliedAt,
  });

  factory InquiryModel.fromJson(Map<String, dynamic> json) {
    return InquiryModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      message: json['message'],
      adminReply: json['adminReply'],
      createdAt: DateTime.parse(json['createdAt']),
      repliedAt: json['repliedAt'] != null
          ? DateTime.parse(json['repliedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
      'adminReply': adminReply,
      'createdAt': createdAt.toIso8601String(),
      'repliedAt': repliedAt?.toIso8601String(),
    };
  }
}