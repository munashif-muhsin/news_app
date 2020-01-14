import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:news_app/modal/interest_per_day.dart';

class IOTPage extends StatefulWidget {
  @override
  _IOTPageState createState() => _IOTPageState();
}

class _IOTPageState extends State<IOTPage> {
  List<charts.Series<InterestPerDay, String>> _createChartData() {
    final data = [
      InterestPerDay('Monday', 100),
      InterestPerDay('Tuesday', 90),
      InterestPerDay('Wednesday', 70),
      InterestPerDay('Thursday', 50),
      InterestPerDay('Friday', 45),
      InterestPerDay('Saturday', 30),
      InterestPerDay('Sunday', 5),
    ];

    return [
      charts.Series<InterestPerDay, String>(
          id: 'InterestPerDay',
          colorFn: (_, __) => charts.MaterialPalette.black,
          domainFn: (InterestPerDay item, _) => item.day,
          measureFn: (InterestPerDay item, _) => item.hits,
          data: data)
    ];
  }

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
      body: Container(
        padding: EdgeInsets.all(20),
        child: charts.BarChart(_createChartData(), animate: true, vertical: false,),
      ),
    );
  }
}


