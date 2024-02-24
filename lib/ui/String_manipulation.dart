import 'package:flutter/material.dart';

import '../Constant.dart';

class StringManipulationTab extends StatefulWidget {
  @override
  _StringManipulationTabState createState() => _StringManipulationTabState();
}

class _StringManipulationTabState extends State<StringManipulationTab> {
  final TextEditingController _inputController = TextEditingController();
  String _outputText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: Constants.manipulatedString_enter_string),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _performManipulation,
            child: const Text(Constants.performManipulation),
          ),
          const SizedBox(height: 20),
          const Text(
            Constants.manipulatedString,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _outputText,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _performManipulation() {
    String inputString = _inputController.text;

    ///Perform string manipulation operations
    String upperCase = inputString.toUpperCase();
    String lowerCase = inputString.toLowerCase();
    String titleCase = toTitleCase(inputString);
    int characterCount =
        countOccurrences(inputString, Constants.manipulate_target_char);

    setState(() {
      _outputText =
          'Uppercase: $upperCase\nLowercase: $lowerCase\nTitle Case: $titleCase\nOccurrences of "a": $characterCount';
    });
  }

  String toTitleCase(String str) {
    return str.replaceAllMapped(RegExp(r'\b\w'), (match) {
      return match.group(0)!.toUpperCase();
    });
  }

  ///target character ex.a and count the character
  int countOccurrences(String input, String targetCharacter) {
    return input.split(targetCharacter).length - 1;
  }
}
