import 'dart:async';

import 'package:news_app/modal/headline.dart';
import 'package:news_app/modal/interest_per_day.dart';
import 'package:news_app/services/news_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InterestOverTimeBloc {
  StreamController<charts.Series<InterestPerDay, String>> _iotStreamController =
      StreamController<charts.Series<InterestPerDay, String>>();

  Stream<charts.Series<InterestPerDay, String>> get iotStream =>
      _iotStreamController.stream;

  void getData(String topic) async {
    _iotStreamController.add(null);
    try {
      final List<Headline> headlines =
          await NewsService.getHeadlinesForChart(topic);
      charts.Series<InterestPerDay, String> result = _analyzeData(headlines);
      _iotStreamController.add(result);
    } catch (e) {
      _iotStreamController.addError(e);
    }
  }

  _analyzeData(List<Headline> headlines) {
    List<int> hitsPerDay = List.filled(7, 0);
    List<String> daysOfTheWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    headlines.forEach((item) {
      hitsPerDay[item.publishedDate.weekday - 1] =
          hitsPerDay[item.publishedDate.weekday - 1] + 1;
    });
    List<InterestPerDay> chartData = [];
    for (var i = 0; i < 7; i++) {
      chartData.add(
        InterestPerDay(
          daysOfTheWeek[i],
          hitsPerDay[i],
        ),
      );
    }

    List<InterestPerDay> rearrangedChartData = [];
    DateTime today = DateTime.now();
    rearrangedChartData.addAll(
      chartData.sublist(today.weekday - 1, 7),
    );
    rearrangedChartData.addAll(chartData.sublist(0, today.weekday));

    return charts.Series<InterestPerDay, String>(
      id: 'InterestPerDay',
      colorFn: (_, __) => charts.MaterialPalette.black,
      domainFn: (InterestPerDay item, _) => item.day,
      measureFn: (InterestPerDay item, _) => item.hits,
      data: rearrangedChartData,
    );
  }
  dispose() {
    _iotStreamController.close();
  }
}
