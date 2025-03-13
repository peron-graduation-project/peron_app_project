class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String date;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'بدون عنوان',
      body: json['body'] ?? 'لا يوجد محتوى',
      date: json['date'] ?? '',
      isRead: json['isRead'] ?? false,
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      date: date,
      isRead: isRead ?? this.isRead,
    );
  }
}
