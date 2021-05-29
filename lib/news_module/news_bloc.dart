import 'dart:async';

import 'package:bloc_news_app/news_module/model/newsinfo.dart';
import 'package:bloc_news_app/news_module/services/api_manager.dart';

enum NewsAction { Fecth, Delete }

class NewsBloc {
  final _stateStreamController = StreamController<List<Article>>();

  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

  NewsBloc() {
    _eventStream.listen((event) async {
      try {
        var news = await APIManager().getNews();
        _newsSink.add(news.articles);
      } on Exception catch (e) {
        _newsSink.addError('Something went wrong');
      }
    });
  }
}
