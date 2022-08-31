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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Morse Code")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: myController,
                    validator: (value) {
                      if (value == "") {
                        return "Enter a message";
                      } else if (!value!.contains(RegExp("r[A-Z a-z]+"))) {
                        return "Message should contain only alphabets";
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          inputText = myController.text;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CodeDisplay(inputText)),
                          );
                        }
                      },
                      child: const Text("Get Morse Code"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
