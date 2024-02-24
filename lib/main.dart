import 'package:flutter/material.dart';
import 'package:flutter_task/ui/Hash_map.dart';
import 'package:flutter_task/ui/List_handling.dart';
import 'package:flutter_task/ui/String_manipulation.dart';

import '../Constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Constants.app_bar_text),
          bottom: const TabBar(
            tabs: [
              Tab(text: Constants.hometab1_text),
              Tab(text: Constants.hometab2_text),
              Tab(text: Constants.hometab3_text),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            List_handling_Tab(),
            HashMapTab(),
            StringManipulationTab(),
          ],
        ),
      ),
    );
  }
}
