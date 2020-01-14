import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:news_app/blocs/interest_ot_bloc.dart';
import 'package:news_app/modal/interest_per_day.dart';

class IOTPage extends StatefulWidget {
  @override
  _IOTPageState createState() => _IOTPageState();
}

class _IOTPageState extends State<IOTPage> {
  InterestOverTimeBloc _timeBloc = InterestOverTimeBloc();
  TextEditingController _editingController = TextEditingController();
  bool _showCancel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            controller: _editingController,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_editingController.text.isNotEmpty) {
                _refreshFeed(_editingController.text);
                setState(() {
                  _showCancel = true;
                });
              }
            },
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for Topic',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
        actions: <Widget>[
          AnimatedOpacity(
            opacity: _showCancel ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                _editingController.clear();
                setState(() {
                  _showCancel = false;
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: StreamBuilder<charts.Series<InterestPerDay, String>>(
          stream: _timeBloc.iotStream,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (_editingController.text.isEmpty) {
              return Center(
                child: Text('Enter a topic to show graph'),
              );
            }
            if(snapshot.data == null) {
              return Center(child: CircularProgressIndicator(),);
            }
            if (snapshot.hasData) {
              return charts.BarChart(
                [snapshot.data],
                animate: true,
                vertical: false,
              );
            }
            return Center(
              child: Text('Something went wrong. Please try again later'),
            );
          },
        ),
      ),
    );
  }

  void _refreshFeed(String text) {
    _timeBloc.getData(text);
  }
}
