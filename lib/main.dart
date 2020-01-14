import 'package:flutter/material.dart';
import 'package:news_app/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: TabsPage(),
      ),
      theme: ThemeData(primaryColor: Colors.black),
    );
  }
}
