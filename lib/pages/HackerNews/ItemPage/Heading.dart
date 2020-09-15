import 'package:catch_up/pages/HackerNews/Data/Item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final Item item;

  Heading({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uri = item.url != null ? Uri.parse(item.url).host : '';

    var children = [
      Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.title}',
              style: TextStyle(fontSize: 24),
            ),
            Text("$uri", style: TextStyle(color: Colors.black87)),
            Text(
              'by ${item.by}',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      )
    ];

    if (item.url != null) {
      children.add(Expanded(
        flex: 0,
        child: InkWell(
          onTap: () async {
            if (await canLaunch("${item.url}")) {
              await launch("${item.url}");
            }
          },
          child: Column(
            children: [Icon(Icons.launch), Text('Launch')],
          ),
        ),
      ));
    }

    return Row(
      children: children,
    );
  }
}
