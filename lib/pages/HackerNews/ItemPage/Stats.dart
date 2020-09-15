import 'package:catch_up/pages/HackerNews/Data/Item.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  final Item item;

  Stats({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Icon(Icons.arrow_drop_up),
                Text('${item.score}'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Icon(Icons.comment),
                Text('${item.descendants}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
