import 'package:catch_up/pages/HackerNews/HackerNewsBloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Feed.dart';

class HackerNews extends StatefulWidget {
  final String title;
  final HackerNewsBloc bloc;

  HackerNews({Key key, this.title, this.bloc}) : super(key: key);

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text(
                'Welcome FireRedNinja',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.hackerNewsSquare),
              title: Text('Hacker News'),
            ),
          ],
        ),
      ),
    );
  }
}
