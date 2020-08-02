import 'package:catch_up/pages/HackerNews/HackerNews.dart';
import 'package:flutter/material.dart';
import 'pages/HackerNews/HackerNews.dart';
import 'pages/HackerNews/HackerNewsBloc.dart';

void main() {
  runApp(CatchUp());
}

class CatchUp extends StatefulWidget {
  CatchUp();

  @override
  _CatchUpState createState() => _CatchUpState();
}

class _CatchUpState extends State<CatchUp> {
  Widget page;
  final hackerNewsBloc = HackerNewsBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatchUp',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HackerNews(bloc: hackerNewsBloc),
    );
  }
}
