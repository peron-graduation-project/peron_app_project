class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'بدون عنوان',
      body: json['body'] ?? 'لا يوجد محتوى',
      date: json['date'] ?? '',
    );
  }
}
