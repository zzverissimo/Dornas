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
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Georgia',
          ),
        automaticallyImplyLeading: false, 
        title: const Text('Chat'),
        backgroundColor: const Color.fromARGB(255, 144, 184, 253),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.delete),
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
                                style: const TextStyle(color: Colors.blueGrey, fontFamily: "Times New Roman"),
                              ),
                            ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(message.userImage),
                            ),
                            title: Text(message.username, style: const TextStyle(color: Colors.black, fontFamily: "Inter", fontWeight: FontWeight.w200)),
                            subtitle: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 217, 224, 237),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(message.text, style: const TextStyle(color: Colors.black, fontFamily: "Inter", fontWeight: FontWeight.w500)),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      formattedTime,
                                      style: const TextStyle(color: Colors.black, fontFamily: "Inter", fontWeight: FontWeight.w500),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 144, 184, 253),
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _messageController,
                        focusNode: _focusNode,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Escribe un mensaje',
                          hintStyle: TextStyle(color: Colors.white, fontFamily: "Inter", fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        onTap: () {
                          _focusNode.requestFocus();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 144, 184, 253),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () async {
                      if (_messageController.text.isNotEmpty) {
                        await chatViewModel.sendMessage(_messageController.text);
                        _messageController.clear();
                        _focusNode.requestFocus();
                        _scrollToBottom();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
