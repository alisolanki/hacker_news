import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/HomePage/widget/drawer_items.dart';
import 'package:hackernews/HomePage/widget/news_widget.dart';
import 'package:hackernews/Login/splash_page.dart';
import 'package:hackernews/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:hackernews/auth/auth.dart' as auth;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> _newsModelList = [];

  @override
  void didChangeDependencies() {
    _fetchNews();
    super.didChangeDependencies();
  }

  Future<void> _fetchNews() async {
    final String _topStoriesUrl = "${auth.mainUrl}topstories.json";
    var res = await http.get(_topStoriesUrl);
    List<String> _ids = res.body.substring(1, res.body.length - 1).split(',');
    _ids.forEach((_id) {
      http.get("${auth.mainUrl}item/$_id.json").then((res) {
        var _decodedData = jsonDecode(res.body);
        setState(() {
          _newsModelList.add(
            NewsModel(
              id: _decodedData['id'] ?? 0,
              title: _decodedData['title'],
              text: _decodedData['text'],
              score: _decodedData['score'] ?? 0,
              by: _decodedData['by'],
              unixTime: _decodedData['time'] ?? 0,
              url: _decodedData['url'],
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Hacker News"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashPage(),
                ),
                (route) => false,
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: DrawerItems(),
      ),
      body: ListView.builder(
        itemBuilder: (_, _i) => NewsWidget(_newsModelList[_i]),
        itemCount: _newsModelList.length,
      ),
    );
  }
}
