import 'dart:io';

import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

String getMorseCode(String input) {
  input = input.toLowerCase();
  input = input.trim();
  final letterToCode = {
    'a': ".-",
    'b': "-...",
    'c': "-.-.",
    'd': "-..",
    'e': ".",
    'f': "..-.",
    'g': "--.",
    'h': "....",
    'i': "..",
    'j': '.---',
    'k': "-.-",
    'l': ".-..",
    'm': "--",
    'n': '-.',
    'o': "---",
    'p': ".--.",
    'q': "--.-",
    'r': ".-.",
    's': "...",
    't': "-",
    'u': "..-",
    'v': "...-",
    'w': ".--",
    'x': '-..-',
    'y': "-.--",
    'z': "--..",
  };

  String result = "";

  for (int i = 0; i < input.length; i++) {
    if (input[i] != ' ') {
      result += letterToCode[input[i]]!;
    } else {
      result += "\t";
    }
  }

  return result;
}

Future<void> startFlashSequence(String morseCode) async {
  bool isTorchAvailable = false;

  try {
    isTorchAvailable = await TorchLight.isTorchAvailable();
  } on Exception catch (_) {
    const ScaffoldMessenger(child: Text("Torch Not Available"));
  }

  const int timeUnit = 90;

  if (isTorchAvailable) {
    for (int i = 0; i < morseCode.length; i++) {
      if (morseCode[i] == '-') {
        await TorchLight.enableTorch();
        sleep(const Duration(milliseconds: 3 * timeUnit));
        await TorchLight.disableTorch();
      } else if (morseCode[i] == '.') {
        await TorchLight.enableTorch();
        sleep(const Duration(milliseconds: timeUnit));
        await TorchLight.disableTorch();
      } else if (morseCode[i] == '\t') {
        sleep(const Duration(milliseconds: timeUnit * 7));
      }

      sleep(const Duration(milliseconds: timeUnit));
    }
  }
}

class CodeDisplay extends StatelessWidget {
  final String inputText;
  const CodeDisplay(this.inputText, {super.key});

  @override
  Widget build(BuildContext context) {
    String morseCode = getMorseCode(inputText);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  inputText.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              const Text("Here is your Morse Code : \n",
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  morseCode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        startFlashSequence(morseCode);
                      },
                      child: const Text("Flash It")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Go back")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
