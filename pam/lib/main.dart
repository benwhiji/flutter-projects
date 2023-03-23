import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final botBackgroundColor = Color(0xFF012f49);
final backgroundColor = Color(0xFF012f49);


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SoftmeetAI(),
  ));
}

class SoftmeetAI extends StatefulWidget {
  const SoftmeetAI({Key? key}) : super(key: key);

  @override
  _SoftmeetAIState createState() => _SoftmeetAIState();
}

class _SoftmeetAIState extends State<SoftmeetAI> {
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Center(
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/robot.jpg'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 2.0, 25.0),
                child: Text(
                  'Pam AI',
                  style: TextStyle(
                    fontSize: 22,
                    height: 2.5,
                    color: Colors.white,
                    decorationThickness: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: botBackgroundColor,
        elevation: 0.0,
      ),
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_light.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return ChatMessageWidget(
                      text: _messages[index].text,
                      chatMessageType: _messages[index].chatMessageType,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _buildInput(),
                    _buildSubmit(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: botBackgroundColor,
      ),
      child: IconButton(
        icon: Icon(
          Icons.send_rounded,
          color: Colors.white,
        ),
        onPressed: () async {
          _sendMessage(_textController.text, ChatMessageType.user);
          _textController.clear();
        },
      ),
    );
  }

  Widget _buildInput() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: botBackgroundColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(color: Colors.white),
            controller: _textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Ask a question ...',
              hintStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage(String text, ChatMessageType type) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        chatMessageType: type,
      ));
    });

    generateResponse(text).then((value) {
      setState(() {
        _messages.add(ChatMessage(
          text: value,
          chatMessageType: ChatMessageType.bot,
        ));
      });
    });
  }

  Future<String> generateResponse(String prompt) async {
    // Replace with your API key and endpoint
    const apiKey = "";

    var url = Uri.https("api.openai.com", "/v1/chat/completions");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $apiKey",
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": prompt}],
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"];
    } else {
      throw Exception("Failed to generate response");
    }
  }
}

enum ChatMessageType {
  user,
  bot,
}

class ChatMessage {
  final String text;
  final ChatMessageType chatMessageType;

  ChatMessage({required this.text, required this.chatMessageType});
}

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;

  ChatMessageWidget({required this.text, required this.chatMessageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: chatMessageType == ChatMessageType.bot
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: chatMessageType == ChatMessageType.bot
                ? botBackgroundColor
                : Color(0xFF154c79),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: chatMessageType == ChatMessageType.bot
                  ? Colors.white
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
