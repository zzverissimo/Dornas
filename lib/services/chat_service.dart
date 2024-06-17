import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Message>> getMessages() {
    return _firestore.collection('messages').orderBy('timestamp').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromFirestore(doc.data())).toList();
    });
  }

  Future<void> sendMessage(Message message) async {
    await _firestore.collection('messages').doc(message.id).set(message.toMap());
  }
}
