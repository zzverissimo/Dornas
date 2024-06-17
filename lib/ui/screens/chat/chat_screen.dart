import 'package:dornas_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Llama a fetchMessages después de un pequeño retraso para permitir que la UI se construya
    Future.delayed(Duration.zero, () {
      final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
      chatViewModel.fetchMessages();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: chatViewModel.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatViewModel.messages[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(message.userImage),
                        ),
                        title: Text(message.username),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(message.text),
                            Text(message.timestamp.toString()),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(labelText: 'Escribe un mensaje'),
                    onTap: () {
                      // Ensure the keyboard is shown
                      _focusNode.requestFocus();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (_messageController.text.isNotEmpty) {
                      await chatViewModel.sendMessage(_messageController.text);
                      _messageController.clear();
                      // Ensure the TextField regains focus
                      _focusNode.requestFocus();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
