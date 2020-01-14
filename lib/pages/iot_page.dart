import 'package:flutter/material.dart';

class IOTPage extends StatefulWidget {
  @override
  _IOTPageState createState() => _IOTPageState();
}

class _IOTPageState extends State<IOTPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for Topic',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}