import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final String username;
  final String userImage;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.username,
    required this.userImage,
  });

  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      id: data['id'] as String,
      senderId: data['senderId'] as String,
      text: data['text'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      username: data['username'] as String,
      userImage: data['userImage'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'username': username,
      'userImage': userImage,
    };
  }
}
