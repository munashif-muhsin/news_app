import 'dart:async';

import 'package:news_app/modal/headline.dart';
import 'package:news_app/services/news_service.dart';

class HeadlinesBloc {

  StreamController<List<Headline>> _headlinesController = StreamController<List<Headline>>();
  Stream<List<Headline>> get headlineStream => _headlinesController.stream;

  refreshFeed(String topic) async {
    _headlinesController.add(null);
    try {
      final List<Headline> headlines = await NewsService.getHeadlines(topic);
      _headlinesController.add(headlines);
    } catch (e) {
      _headlinesController.addError(e);
    }
  }
  
}