import 'package:flutter/material.dart';
import 'package:hackernews/HomePage/widget/news_widget.dart';
import 'package:hackernews/models/news_model.dart';
import 'package:hackernews/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<NewsModel> _newsModels = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _newsModels = Provider.of<NewsProvider>(context).newsModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("History"),
      ),
      body: ListView.builder(
        itemBuilder: (_, _i) => NewsWidget(_newsModels[_i]),
        itemCount: _newsModels.length,
      ),
    );
  }
}
