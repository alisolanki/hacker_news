import 'package:flutter/material.dart';
import 'package:hackernews/models/news_model.dart';
import 'package:hackernews/provider/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatelessWidget {
  final NewsModel _newsModel;
  NewsWidget(this._newsModel);

  void _launchURL({@required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "by ${_newsModel.by}",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 16.0),
            title: Text("${_newsModel.title}"),
            subtitle: Text("${_newsModel.text}"),
            onTap: () {
              _launchURL(url: _newsModel.url);
              Provider.of<NewsProvider>(context, listen: false)
                  .incrementCount(_newsModel);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(
                    " ${_newsModel.score}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.orange,
                ),
                onPressed: () => Share.share(
                  "Look at what I found on Hacker News App: ${_newsModel.url}",
                ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
