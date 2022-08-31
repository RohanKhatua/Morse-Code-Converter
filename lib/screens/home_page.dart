import 'package:flutter/material.dart';
import 'package:morse_code/screens/code_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  String inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Morse Code")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myController,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                inputText = myController.text;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CodeDisplay(inputText)),
                );
              },
              child: const Text("Get Morse Code")),
        ],
      ),
    );
  }
}
