import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/HomePage/widget/drawer_items.dart';
import 'package:hackernews/HomePage/widget/news_widget.dart';
import 'package:hackernews/Login/splash_page.dart';
import 'package:hackernews/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:hackernews/auth/auth.dart' as auth;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // var _isInit = true, _isLoading = true;
  List<NewsModel> _newsModelList = [];

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     _fetchData();
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  // void _fetchData() async {
  //   await Provider.of<NewsProvider>(context, listen: false).fetchTopStories();
  //   setState(() {
  //     _newsModelList =
  //         Provider.of<NewsProvider>(context, listen: false).topStoriesList;
  //     _isLoading = false;
  //   });
  //   print("length:: ${_newsModelList.length}");
  // }

  Stream _stream;
  StreamController _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<NewsModel>>();
    _stream = _streamController.stream;
    fetchTopStories();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.done;
  }

  void fetchTopStories() async {
    final String _topStoriesUrl = "${auth.mainUrl}topstories.json";
    try {
      List<String> _ids = [];
      await http.get(_topStoriesUrl).then((res1) async {
        _ids = res1.body.substring(1, res1.body.length - 1).split(',');
      });
      for (String _id in _ids) {
        await http.get("${auth.mainUrl}item/$_id.json").then((res2) {
          var _decodedData = jsonDecode(res2.body);
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
          _streamController.add(_newsModelList);
        });
      }
      print("returning");
    } catch (e) {
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("News"),
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
      body: StreamBuilder<List<NewsModel>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return throw ("Fetching News Page went wrong");
          }
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (_, _i) => NewsWidget(snapshot.data[_i]),
            itemCount: snapshot.data.length,
          );
        },
      ),
    );
  }
}
