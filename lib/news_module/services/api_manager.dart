import 'dart:convert';
import 'package:bloc_news_app/constant/constants.dart';
import 'package:bloc_news_app/news_module/model/newsinfo.dart';
import 'package:http/http.dart' as http;

class APIManager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(news_url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (e) {
      return newsModel;
    }
    return newsModel;
  }
}
