import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_tutorial_yt/pages/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(
            25, 234, 255, 1.0)).copyWith(primaryContainer: const Color.fromARGB(255, 255, 255, 255),
      secondaryContainer: const Color.fromARGB(255, 255, 255, 255),
      brightness: Brightness.light),
      ),
      home: ChatPage(),
    );
  }
}
