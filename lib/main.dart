import 'package:catch_up/pages/GitHub/GitHub.dart';
import 'package:catch_up/pages/GitHub/GitHubBloc.dart';
import 'package:catch_up/pages/HackerNews/HackerNews.dart';
import 'package:catch_up/pages/HackerNews/HackerNewsBloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CatchUp());
}

class CatchUp extends StatefulWidget {
  CatchUp();

  @override
  _CatchUpState createState() => _CatchUpState();
}

class _CatchUpState extends State<CatchUp> {
  final hackerNewsBloc = HackerNewsBloc();
  final githubBloc = GitHubBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatchUp',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/hackernews',
      routes: {
        '/hackernews': (context) => HackerNews(bloc: hackerNewsBloc),
        '/github': (context) => GitHub(bloc: githubBloc),
      },
    );
  }
}
