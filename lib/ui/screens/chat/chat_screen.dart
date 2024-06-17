import 'package:dornas_app/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
      chatViewModel.fetchMessages();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await chatViewModel.clearMessages();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: chatViewModel.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatViewModel.messages[index];
                      final isToday = DateTime.now().difference(message.timestamp).inDays == 0;
                      final isYesterday = DateTime.now().difference(message.timestamp).inDays == 1;
                      final formattedTime = DateFormat('HH:mm').format(message.timestamp);
                      final dateLabel = isToday ? 'Hoy' : isYesterday ? 'Ayer' : DateFormat('dd/MM/yyyy').format(message.timestamp);

                      return Column(
                        children: [
                          if (index == 0 || DateFormat('dd/MM/yyyy').format(chatViewModel.messages[index - 1].timestamp) != DateFormat('dd/MM/yyyy').format(message.timestamp))
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                dateLabel,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(message.userImage),
                            ),
                            title: Text(message.username),
                            subtitle: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(message.text),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      formattedTime,
                                      style: TextStyle(fontSize: 10, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                      _focusNode.requestFocus();
                      _scrollToBottom();
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
