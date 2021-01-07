import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  final int _index;
  NewsWidget(this._index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "by Ali Solanki",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 16.0),
            title: Text(
                "This is the long ass Title that probably no one will read but I will write it anyway because who knows what might just happen"),
            subtitle: Text(
                "This is the long ass Title that probably no one will read but I will write it anyway because who knows what might just happenThis is the long ass Title that probably no one will read but I will write it anyway because who knows what might just happen"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                  ),
                  Text(
                    " 114",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              IconButton(icon: Icon(Icons.share), onPressed: () {})
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
