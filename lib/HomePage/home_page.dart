import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackernews/HomePage/history_page.dart';
import 'package:hackernews/HomePage/widget/drawer_items.dart';
import 'package:hackernews/Login/splash_page.dart';
import 'package:hackernews/models/news_model.dart';
import 'package:hackernews/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> _newsModels = [];
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _newsModels = Provider.of<NewsProvider>(context).newsModels;
    }
    _isInit = false;
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
      body: Center(
        child: RaisedButton(
          color: Colors.orange,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "${_newsModels.length}",
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
              ),
            ),
          ),
          onPressed: () {
            if (_newsModels.length == 0) {
              Fluttertoast.showToast(msg: "No news clicked");
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HistoryPage(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
