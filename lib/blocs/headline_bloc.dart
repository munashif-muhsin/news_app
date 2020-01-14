import 'dart:async';

import 'package:news_app/modal/headline.dart';
import 'package:news_app/services/news_service.dart';

class HeadlinesBloc {
  StreamController<List<Headline>> _headlinesController =
      StreamController<List<Headline>>();
  Stream<List<Headline>> get headlineStream => _headlinesController.stream;

  bool _autoUpdateLock = false;
  bool _shouldAutoUpdate = false;
  String _searchText;

  refreshFeed(String topic) async {
    _headlinesController.add(null);
    _getFeed(topic);
  }

  toggleAutoUpdate(String text) {
    _shouldAutoUpdate = !_shouldAutoUpdate;
    if (!_autoUpdateLock) {
      _searchText = text;
      onAutoRefreshCAllback();
    }
  }

  void onAutoRefreshCAllback() {
    _autoUpdateLock = true;
    Future.delayed(Duration(seconds: 30), () {
      if (!_shouldAutoUpdate) {
        return _autoUpdateLock = false;
      }
      _getFeed(_searchText);
      onAutoRefreshCAllback();
    });
  }

  _getFeed(String topic) async {
    try {
      final List<Headline> headlines = await NewsService.getHeadlines(topic);
      _headlinesController.add(headlines);
    } catch (e) {
      _headlinesController.addError(e);
    }
  }
}
