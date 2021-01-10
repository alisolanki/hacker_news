import 'package:flutter/material.dart';
import 'package:hackernews/HomePage/home_page.dart';
import 'package:hackernews/provider/news_provider.dart';
import 'package:provider/provider.dart';

class Startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NewsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
