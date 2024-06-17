import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/message_model.dart';
import 'package:dornas_app/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ChatViewModel() {
    fetchMessages();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void fetchMessages() {
    setLoading(true);
    _chatService.getMessages().listen((messages) {
      _messages = messages;
      setLoading(false);
      notifyListeners();
    }, onError: (error) {
      setMessage(error.toString());
      setLoading(false);
    });
  }

  Future<void> sendMessage(String text) async {
    setLoading(true);
    setMessage(null);
    try {
      final user = _auth.currentUser!;
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final message = Message(
        id: DateTime.now().toString(), // ID único para el mensaje
        senderId: user.uid, // ID del usuario que envió el mensaje
        text: text,
        timestamp: DateTime.now(),
        username: userData['displayName'],
        userImage: userData['photoUrl'],
      );
      await _chatService.sendMessage(message);
      // No es necesario volver a llamar a fetchMessages, ya que estamos usando Stream
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
