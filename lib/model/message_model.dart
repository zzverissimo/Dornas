import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final String username;
  final String userImage;
  final List<String> deletedBy;  // Nueva propiedad

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.username,
    required this.userImage,
    required this.deletedBy,  // Inicializar en el constructor
  });

  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      id: data['id'] as String,
      senderId: data['senderId'] as String,
      text: data['text'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      username: data['username'] as String,
      userImage: data['userImage'] as String,
      deletedBy: List<String>.from(data['deletedBy'] ?? []),  // Inicializar lista
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
      'deletedBy': deletedBy,  // Añadir a Map
    };
  }
}
