import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_flutter/models/load_state.dart';

import '../models/article_model.dart';

class News {
  Result result = Result(LoadStates.loading, []);
  String url = "";

  Future<void> getNews(String category) async {
    if (category == "") {
      url =
          "https://newsapi.org/v2/top-headlines?language=en&apiKey=bf653a4bb3fa4ca3898fdcfabaef88df";
    } else {
      url =
          "https://newsapi.org/v2/top-headlines?category=$category&language=en&apiKey=bf653a4bb3fa4ca3898fdcfabaef88df";
    }
    try {
      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);

      result.loadState = LoadStates.success;
      var articles = jsonData["articles"];
      articles.forEach((article) {
        ArticleModel articleModel = ArticleModel(
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage']);
        result.data.add(articleModel);
      });
    } catch (e) {
      result.loadState = LoadStates.error;
    }
  }
}
