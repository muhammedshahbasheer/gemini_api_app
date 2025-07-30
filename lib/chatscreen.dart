import 'package:flutter/material.dart';
import 'package:gemini_api_app/services.dart';

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  TextEditingController promptdata = TextEditingController();
  String response = '';
  bool loading = false;
  List<Map<String, String>> Message = [];
  ScrollController scrollController = ScrollController();
  void sendmessage() async {
    final prompt = promptdata.text.trim();
    if (prompt.isEmpty) return null;
    setState(() {
      Message.add({"role": "user", "message": prompt});
      loading = true;
      response = '';
    });
    final reply = await chats(prompt);
    setState(() {
      Message.add({"role": "bot", "message": reply});
      response = reply;
      loading = false;
    });
    promptdata.clear();
  }

  Widget chatBubble(String message, bool isUser) {
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: TextStyle(color: isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("chat bot ai"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: Message.length,
              itemBuilder: (context, index) {
                final msg = Message[index];
                return chatBubble(msg["message"] ?? '', msg["role"] == "user");
              },
            ),
          ),
          loading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Text(response),
                ),
          TextField(
            controller: promptdata,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      sendmessage();
                    },
                    icon: Icon(Icons.send))),
          ),SizedBox(height: 40,)
        ],
      ),
    );
  }
}
