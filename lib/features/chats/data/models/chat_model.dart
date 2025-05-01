class ChatModel {
  final String chatWithId;
  final String name;
  final String photo;
  final String lastMessage;
  final String timestamp;
  final bool isRead;
  final int unReadCount;

  ChatModel({
    required this.chatWithId,
    required this.name,
    required this.photo,
    required this.lastMessage,
    required this.timestamp,
    required this.isRead,
    required this.unReadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatWithId: json['chatWithId'] ?? '',
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      timestamp: json['timestamp'] ?? '',
      isRead: json['isRead'] ?? false,
      unReadCount: json['unReadCount']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatWithId': chatWithId,
      'name': name,
      'photo': photo,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'isRead': isRead,
      'unReadCount': unReadCount,
    };
  }
}
