import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  NewsModel _newsModel;
}
