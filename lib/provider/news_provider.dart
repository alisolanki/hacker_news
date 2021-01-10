import 'package:flutter/material.dart';
import 'package:hackernews/models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> _newsModels = [];

  List<NewsModel> get newsModels {
    return _newsModels;
  }

  void incrementCount(NewsModel _news) {
    print("Add: $_news");
    _newsModels.add(_news);
    notifyListeners();
  }
}
