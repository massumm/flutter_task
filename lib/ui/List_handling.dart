import 'package:flutter/material.dart';
import 'package:flutter_task/utils/Toast_util.dart';

import '../Constant.dart';
import '../utils/DialogUtil.dart';

class List_handling_Tab extends StatefulWidget {
  @override
  _List_handling_TabState createState() => _List_handling_TabState();
}

class _List_handling_TabState extends State<List_handling_Tab> {
  List<String> itemList = ['kamal', 'russel', 'sajib'];
  String userInput = '';

  void addItem() {
    setState(() {
      if (userInput.isNotEmpty) {
        itemList.add(userInput);
        userInput = '';
      } else {
        ToastUtil.showToast(context, Constants.empty_warning_txt);
      }
    });
  }

  void _showDeleteConfirmation(int index) {
    DialogUtil.showConfirmationDialog(
      context,
      Constants.popup_title_txt,
      Constants.popup_description_txt,
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        removeItem(index);
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                labelText: Constants.list_handling_inpt_txt),
            onChanged: (value) {
              userInput = value;
            },
            onSubmitted: (_) {
              addItem();
            },
          ),
          ElevatedButton(
            onPressed: addItem,
            child: const Text(Constants.add_btn_txt),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(itemList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmation(index);
                      },
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
