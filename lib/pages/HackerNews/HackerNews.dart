import 'package:catch_up/pages/HackerNews/HackerNewsBloc.dart';
import 'package:flutter/material.dart';
import 'package:catch_up/pages/HackerNews/Feed.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
        actions: <Widget>[
          DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            icon: Icon(Icons.sort),
            iconEnabledColor: Colors.white,
            items: <String>['Best', 'Top', 'New']
                .map<DropdownMenuItem<String>>((String value) =>
                    DropdownMenuItem<String>(value: value, child: Text(value)))
                .toList(),
            onChanged: (String value) {
              setState(() {
                sortValue = value;
              });
            },
          )),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: Feed(sort: sortValue, bloc: widget.bloc),
      drawer: CatchUpDrawer(),
    );
  }
}
