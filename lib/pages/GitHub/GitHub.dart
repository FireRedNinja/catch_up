import 'package:flutter/material.dart';
import 'package:catch_up/CatchUpDrawer.dart';

class GitHub extends StatefulWidget {
  @override
  _GitHubState createState() => _GitHubState();
}

class _GitHubState extends State<GitHub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub'),
      ),
      body: Container(),
      drawer: CatchUpDrawer(),
    );
  }
}
