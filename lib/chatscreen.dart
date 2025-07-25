import 'package:flutter/material.dart';
import 'package:gemini_api_app/services.dart';

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  TextEditingController promptdata=TextEditingController();
  String response='';
  bool loading=false;
  void sendmessage()async{final prompt=promptdata.text.trim();if(prompt.isEmpty)return null;
  setState(() {
    loading=true;
    response='';
  });
  final reply=await chats(prompt);
  setState(() {
    response=reply;
    loading=false;

  });
  promptdata.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: promptdata,
            decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: (){sendmessage();}, icon: Icon(Icons.send))),
          ),
          loading?CircularProgressIndicator():SingleChildScrollView(child: Text(response),)
        ],
      ),
    );
  }
}
