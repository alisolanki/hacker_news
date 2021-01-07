import 'package:flutter/material.dart';
import 'package:hackernews/HomePage/widget/news_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, _index) => NewsWidget(_index),
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
