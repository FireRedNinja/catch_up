import 'package:catch_up/pages/HackerNews/HackerNewsBloc.dart';
import 'package:flutter/material.dart';
import 'package:catch_up/pages/HackerNews/Feed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:catch_up/CatchUpDrawer.dart';

class HackerNews extends StatefulWidget {
  final HackerNewsBloc bloc;

  HackerNews({Key key, this.bloc}) : super(key: key);

  @override
  _HackerNewsState createState() => _HackerNewsState();
}

class _HackerNewsState extends State<HackerNews> {
  String sortValue = 'Top';

  @override
  Widget build(BuildContext context) {
    widget.bloc.storiesType.add(StoriesType.topStories);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
        actions: <Widget>[
          PopupMenuButton<String>(
              icon: Icon(Icons.sort),
              onSelected: (String value) {
                switch (value) {
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
                setState(() {
                  sortValue = value;
                });
              },
              itemBuilder: (BuildContext context) => <String>[
                    'Best',
                    'Top',
                    'New'
                  ]
                      .map((String value) => PopupMenuItem<String>(
                          value: value, child: Text(value)))
                      .toList()),
          PopupMenuButton(
              onSelected: (String value) async {
                if (await canLaunch("https://news.ycombinator.com/")) {
                  await launch("https://news.ycombinator.com/");
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "Go to site",
                      child: Text('Go To Hacker News'),
                    )
                  ]),
        ],
      ),
      body: Feed(bloc: widget.bloc),
      drawer: CatchUpDrawer(),
    );
  }
}
