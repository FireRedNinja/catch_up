import 'package:catch_up/pages/HackerNews/Data/Item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewComments extends StatelessWidget {
  final Item item;

  ViewComments({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          if (await canLaunch(
              "https://news.ycombinator.com/item?id=${item.id}")) {
            await launch("https://news.ycombinator.com/item?id=${item.id}");
          }
        },
        child: Text('View comments'),
      ),
    );
  }
}
