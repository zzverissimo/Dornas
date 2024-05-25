import 'package:dornas_app/model/message_model.dart';
import 'package:dornas_app/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatService _chatService = ChatService();

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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

  Future<void> sendMessage(String text, String senderId) async {
    setLoading(true);
    setMessage(null);
    try {
      final message = Message(
        id: DateTime.now().toString(),
        senderId: senderId,
        text: text,
        timestamp: DateTime.now(),
      );
      await _chatService.sendMessage(message);
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
