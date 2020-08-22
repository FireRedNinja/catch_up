import 'package:catch_up/pages/GitHub/GitHub.dart';
import 'package:catch_up/pages/GitHub/GitHubBloc.dart';
import 'package:catch_up/pages/HackerNews/HackerNews.dart';
import 'package:catch_up/pages/HackerNews/HackerNewsBloc.dart';
import 'package:catch_up/pages/ProductHunt/ProductHunt.dart';
import 'package:catch_up/pages/ProductHunt/ProductHuntBloc.dart';
import 'package:catch_up/utils/themeData.dart';
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
  String _page = 'Hacker News';
  final hackerNewsBloc = HackerNewsBloc();
  final githubBloc = GitHubBloc();
  final productHuntBloc = ProductHuntBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatchUp',
      theme: gettheme(_page),
      initialRoute: '/hackernews',
      routes: {
        '/hackernews': (context) {
          _page = 'Hacker News';
          return HackerNews(bloc: hackerNewsBloc);
        },
        '/github': (context) {
          _page = 'GitHub';
          return GitHub(bloc: githubBloc);
        },
        '/producthunt': (context) {
          _page = 'Product Hunt';
          return ProductHunt(bloc: productHuntBloc);
        }
      },
    );
  }
}
