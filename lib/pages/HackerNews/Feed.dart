import 'dart:collection';

import 'package:catch_up/pages/HackerNews/HackerNewsBloc.dart';
import 'package:catch_up/pages/HackerNews/ItemPage/ItemPage.dart';
import 'package:flutter/material.dart';
import './Data/Item.dart';

class Feed extends StatefulWidget {
  final HackerNewsBloc bloc;

  Feed({Key key, this.bloc}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UnmodifiableListView<Item>>(
      stream: widget.bloc.items,
      initialData: UnmodifiableListView<Item>([]),
      builder: (builderContext, snapshot) => ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext itemBuilderContext, int index) {
          if (snapshot.data[index] == snapshot.data.last) {
            widget.bloc.getItemsAndUpdate(index + 1, 10);
          }
          return _buildListTile(snapshot.data[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _buildListTile(Item item) {
    DateTime now = DateTime.now();
    DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(item.time * 1000);
    Duration createdAgo = now.difference(createdAt);
    String agoString;
    if (createdAgo.inDays > 0) {
      agoString = '${createdAgo.inDays} days ago';
    } else if (createdAgo.inHours > 0) {
      agoString = '${createdAgo.inHours} hours ago';
    } else {
      agoString = '${createdAgo.inMinutes} minutes ago';
    }

    String uri = item.url != null ? Uri.parse(item.url).host : '';

    return ListTile(
      leading: Column(
        children: [
          Icon(Icons.arrow_drop_up),
          Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          Text("${item.score}")
        ],
      ),
      title: Text('${item.title}'),
      subtitle: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: Text('${item.by} | $agoString')),
          Container(
            child: Text('$uri'),
            alignment: Alignment.topLeft,
          )
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemPage(
                        item: item,
                      )));
        },
        child: Column(
          children: [
            Icon(Icons.comment),
            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
            Text("${item.descendants}"),
          ],
        ),
      ),
    );
  }
}
