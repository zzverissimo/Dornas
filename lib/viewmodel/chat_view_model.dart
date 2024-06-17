import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Message> _messages = [];
  List<Message> get messages => _messages;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ChatViewModel() {
    fetchMessages();
  }

  void fetchMessages() async {
    _isLoading = true;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser!;
    _firestore.collection('messages').orderBy('timestamp').snapshots().listen((snapshot) {
      _messages = snapshot.docs.map((doc) => Message.fromFirestore(doc.data()))
        .where((message) => !message.deletedBy.contains(user.uid)) // Filtrar mensajes "borrados"
        .toList();
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> sendMessage(String text) async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await _firestore.collection('users').doc(user.uid).get();
    final message = Message(
      id: DateTime.now().toString(),
      senderId: user.uid,
      text: text,
      timestamp: DateTime.now(),
      username: userData['displayName'],
      userImage: userData['photoUrl'],
      deletedBy: [], // Inicializar lista vacía
    );
    await _firestore.collection('messages').doc(message.id).set(message.toMap());
  }

  Future<void> clearMessages() async {
    final user = FirebaseAuth.instance.currentUser!;
    // Actualiza todos los mensajes para marcar como "borrados" por el usuario actual
    final batch = _firestore.batch();
    final querySnapshot = await _firestore.collection('messages').get();
    for (var doc in querySnapshot.docs) {
      batch.update(doc.reference, {
        'deletedBy': FieldValue.arrayUnion([user.uid])
      });
    }
    await batch.commit();

    // Actualiza localmente también
    _messages = [];
    notifyListeners();
  }
}
