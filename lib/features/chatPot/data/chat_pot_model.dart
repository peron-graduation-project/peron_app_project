class ChatBotMessage {
  final int? id;
  final String? userId;
  final String? messageText;
  final String? timestamp;
  final String? sender;

  ChatBotMessage( {
  this.id,
  this.userId,
  this.messageText,
  this.timestamp,
  this.sender,

  });

  factory ChatBotMessage.fromJson(Map<String, dynamic> json) {
  return ChatBotMessage(
  id: json['id'] ?? 0,
  messageText: json['messageText'] ?? "",
  timestamp: json['timestamp'] ?? "",
  sender: json['sender'] ??'',
  userId: json['userId']??"",

  );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'messageText': messageText,
      'timestamp': timestamp,
      'sender': sender,


    };
  }
}
