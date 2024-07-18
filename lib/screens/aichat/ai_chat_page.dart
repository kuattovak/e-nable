import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/aichat/request_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController promptText = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {
      'text': 'Hello! I am here to help you. Ask your questions.',
      'isUser': false,
    }
  ];

  Future<String> gptTaskSolution() async {
    String requestText = promptText.text;
    setState(() {
      messages.add({"text": requestText, "isUser": true});
    });
    promptText.clear();
    // Make the API request
    var response = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAWEarvDDJP5uI8hFQ8L0uXba3CjrxOGCs'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "contents": [
          {
            "role": "user",
            "parts": [
              {"text": requestText}
            ]
          }
        ],
      }),
    );
    ImageResponse text = ImageResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      setState(() {
        messages.add({
          'text': text.candidates!.first.content!.parts!.first.text!,
          'isUser': false
        });
      });
    }

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'E-nable expert',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Color(0xff1F59DA), fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: messages[index]['text'],
                  isUser: messages[index]['isUser'],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(246, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Ask from a specialist',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 13, color: Color(0xffA1A1A1)),
                        focusColor: Colors.black),
                    controller: promptText,
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: gptTaskSolution,
                    child: Text('Send'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1F59DA),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({
    required this.text,
    required this.isUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: isUser ? Color(0xff1F59DA) : Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, color: isUser ? Colors.white : Color(0xff505050)),
        ),
      ),
    );
  }
}
