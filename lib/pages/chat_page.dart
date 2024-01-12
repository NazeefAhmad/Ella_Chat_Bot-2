import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_tutorial_yt/consts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
    token: "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",
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 20,
      ),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser =
  ChatUser(id: '1', firstName: 'Nazeef', lastName: 'Ahmad',);
  final ChatUser _gptChatUser =

  ChatUser(id: '2', firstName: 'Ella', lastName: '');

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,

      appBar: AppBar(
backgroundColor: colors.Transparent,

),
      body: DashChat(


          currentUser: _currentUser,

          typingUsers: _typingUsers,
          messageOptions: const MessageOptions(
            currentUserContainerColor: Color.fromRGBO(
                2, 60, 114, 1.0),

            containerColor: Color.fromRGBO(
              198,
              131,
              215,
              1.0,

            ),
            textColor: Colors.white,
          ),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },

          messages: _messages),

    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
      model: GptTurbo16k0631Model(),
      messages: _messagesHistory,
      maxToken: 250,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: element.message!.content),
          );
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}
