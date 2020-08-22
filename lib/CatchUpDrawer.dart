import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CatchUpDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
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
            onTap: () {
              Navigator.popAndPushNamed(context, '/hackernews');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.github),
            title: Text('GitHub'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/github');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.productHunt),
            title: Text('Product Hunt'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/producthunt');
            },
          )
        ],
      ),
    );
  }
}
