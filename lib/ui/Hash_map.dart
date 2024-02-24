import 'package:flutter/material.dart';

import '../Constant.dart';
import '../utils/DialogUtil.dart';

class HashMapTab extends StatefulWidget {
  @override
  _HashMapTabState createState() => _HashMapTabState();
}

class _HashMapTabState extends State<HashMapTab> {
  Map<String, String> dataMap = {
    "kamal": "25",
    "sajib": "30",
    "Bob": "28",
  };
  bool _validateName = false;
  bool _validateAge = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Constants.hashmap_name_txt),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Constants.hashmap_age_txt),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _addNameAgePair,
                child: const Text(Constants.add_btn_txt),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: dataMap.length,
              itemBuilder: (context, index) {
                String key = dataMap.keys.elementAt(index);
                String value = dataMap.values.elementAt(index);
                return ListTile(
                  title: Text(key),
                  subtitle: Text(value),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showUpdateDialog(key),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _showDeleteConfirmation(key),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///age and name adding function
  void _addNameAgePair() {
    String name = _nameController.text;
    String age = _ageController.text;
    if (name.isNotEmpty && age.isNotEmpty) {
      ///here age act as key value
      setState(() {
        dataMap[name] = age;
      });
      _nameController.clear();
      _ageController.clear();
    } else {}
  }

  void _showDeleteConfirmation(String key) {
    DialogUtil.showConfirmationDialog(
      context,
      Constants.popup_title_txt,
      Constants.popup_description_txt,
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        _removeNameAgePair(key);
      }
    });
  }

  void _showUpdateDialog(String key) {
    String currentName = key;
    String? currentAge = dataMap[key];
    TextEditingController nameController =
        TextEditingController(text: currentName);
    TextEditingController ageController =
        TextEditingController(text: currentAge);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(Constants.update_popup_title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        errorText:
                            _validateName ? 'Name cannot be empty' : null),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                        errorText: _validateAge ? 'Age cannot be empty' : null),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Update'),
                  onPressed: () {
                    setState(() {
                      _validateName = nameController.text.isEmpty;
                      _validateAge = ageController.text.isEmpty;
                    });
                    if (!_validateName && !_validateAge) {
                      String updatedName = nameController.text;
                      String updatedAge = ageController.text;
                      setState(() {
                        dataMap.remove(key);
                        dataMap[updatedName] = updatedAge;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ]);
        });
  }

  ///age and name delete function
  void _removeNameAgePair(String key) {
    setState(() {
      dataMap.remove(key);
    });
  }
}
