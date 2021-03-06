import 'dart:convert';

import 'package:news_app/apis.dart';
import 'package:news_app/modal/headline.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static Future<List<Headline>> getHeadlines(String topic) async {
    try {
      String url;
      if (topic == null) {
        url = APIs.serverURL +
            APIs.headlines +
            '?country=in&apiKey=${APIs.apiKey}';
      } else {
        url =
            APIs.serverURL + APIs.headlines + '?q=$topic&apiKey=${APIs.apiKey}';
      }
      final response = await http.get(url);
      final jsonData = (json.decode(response.body))['articles'];
      return _createHeadlineList(jsonData);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static List<Headline> _createHeadlineList(jsonData) {
    List<Headline> headlines = [];
    jsonData.forEach((item) {
      headlines.add(Headline(
        author: item['author'] == null ? 'No Author' : item['author'],
        description: item['description'] == null
            ? 'No description'
            : item['description'],
        imageUrl: item['urlToImage'] == null ? '' : item['urlToImage'],
        publishedDate: DateTime.parse(item['publishedAt']),
        title: item['title'],
      ));
    });
    return headlines;
  }

  static Future<List<Headline>> getHeadlinesForChart(String topic) async {
    try {
      String startDate =
          DateTime.now().subtract(Duration(days: 7)).toIso8601String();
      String endDate = DateTime.now().toIso8601String();
      String url = APIs.serverURL +
          APIs.everything +
          '?q=$topic&apiKey=${APIs.apiKey}&from=$startDate&end=$endDate&pageSize=100';
      final response = await http.get(url);
      final jsonData = (json.decode(response.body))['articles'];
      return _createHeadlineList(jsonData);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
