import 'package:flutter/material.dart';

class NewsModel {
  final int id, score, unixTime;
  final String title, text, by, url;
  NewsModel({
    @required this.id,
    @required this.title,
    @required this.text,
    @required this.score,
    @required this.by,
    @required this.unixTime,
    @required this.url,
  });
}
