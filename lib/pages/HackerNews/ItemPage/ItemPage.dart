import 'package:catch_up/pages/HackerNews/Data/Item.dart';
import 'package:catch_up/pages/HackerNews/ItemPage/Heading.dart';
import 'package:catch_up/pages/HackerNews/ItemPage/Stats.dart';
import 'package:catch_up/pages/HackerNews/ItemPage/ViewComments.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  final Item item;

  ItemPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Heading(item: item)];

    if (item.text != null) {
      children = children +
          [Text("${item.text}"), Padding(padding: EdgeInsets.only(bottom: 20))];
    }

    children = children +
        [
          Padding(padding: EdgeInsets.only(bottom: 28)),
          Stats(item: item),
          Padding(padding: EdgeInsets.only(bottom: 4)),
          ViewComments(item: item)
        ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
