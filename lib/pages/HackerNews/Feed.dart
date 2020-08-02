import 'dart:collection';

import 'package:catch_up/pages/HackerNews/HackerNewsBloc.dart';
import 'package:flutter/material.dart';
import './Data/Item.dart';
import 'package:url_launcher/url_launcher.dart';

class Feed extends StatefulWidget {
  final String sort;
  final HackerNewsBloc bloc;

  Feed({Key key, this.sort, this.bloc}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    switch (widget.sort) {
      case 'Best':
        widget.bloc.storiesType.add(StoriesType.bestStories);
        break;
      case 'Top':
        widget.bloc.storiesType.add(StoriesType.topStories);
        break;
      case 'New':
        widget.bloc.storiesType.add(StoriesType.newStories);
        break;
    }

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
    return ListTile(
      title: Text('${item.title}'),
      subtitle: Text(
          '${item.score} points by ${item.by} ${item.time} ago | ${item.descendants} comments | ${item.url}'),
      trailing: Icon(Icons.launch),
      onTap: () async {
        if (await canLaunch(item.url)) {
          await launch(item.url);
        }
      },
    );
  }
}
