class Message {
  final int id;
  final String message;
  final String timestamp;
  final bool isRead;
  final bool isMe;
  final String? senderName;
  final String? senderPhoto;

  Message({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.isMe,
    required this.senderName,
    required this.senderPhoto,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      timestamp: json['timestamp'],
      isRead: json['isRead'],
      isMe: json['isMe'],
      senderName: json['senderName']??"",
      senderPhoto: json['senderPhoto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp,
      'isRead': isRead,
      'isMe': isMe,
      'senderName': senderName??'',
      'senderPhoto': senderPhoto,
    };
  }
}
