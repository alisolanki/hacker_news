import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:hackernews/auth/auth.dart' as auth;

class NewsProvider extends ChangeNotifier {
  NewsModel _newsModel;

  NewsModel get newsModel {
    return _newsModel;
  }

  Future<void> fetchNews() async {
    final String _topStoriesUrl = "${auth.mainUrl}topstories.json";
    var res = await http.get(_topStoriesUrl);
    List<String> ids = res.body.substring(1, res.body.length - 1).split(',');
  }
}
