import 'dart:collection';

import 'package:catch_up/pages/GitHub/GitHubBloc.dart';
import 'package:flutter/material.dart';
import 'package:catch_up/CatchUpDrawer.dart';
import 'package:catch_up/pages/GitHub/Data/Repo.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHub extends StatefulWidget {
  final GitHubBloc bloc;

  GitHub({Key key, this.bloc}) : super(key: key);

  @override
  _GitHubState createState() => _GitHubState();
}

class _GitHubState extends State<GitHub> {
  String sortValue;

  @override
  Widget build(BuildContext context) {
    widget.bloc.sortType.add(SortType.today);

    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub'),
        actions: <Widget>[
          DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            icon: Icon(Icons.sort),
            iconEnabledColor: Colors.white,
            items: <String>['Today', 'This Week', 'This Month']
                .map<DropdownMenuItem<String>>((String value) =>
                    DropdownMenuItem<String>(value: value, child: Text(value)))
                .toList(),
            onChanged: (String value) {
              switch (value) {
                case 'Today':
                  widget.bloc.sortType.add(SortType.today);
                  break;
                case 'This Week':
                  widget.bloc.sortType.add(SortType.thisWeek);
                  break;
                case 'This Month':
                  widget.bloc.sortType.add(SortType.thisMonth);
                  break;
                default:
              }
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
      body: StreamBuilder<UnmodifiableListView<Repo>>(
        stream: widget.bloc.repos,
        initialData: UnmodifiableListView<Repo>([]),
        builder: (builderContext, snapshot) => ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext repoBuilderContext, int index) {
            return _buildListTile(snapshot.data[index], repoBuilderContext);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
      drawer: CatchUpDrawer(),
    );
  }
}

Widget _buildListTile(Repo repo, BuildContext context) {
  return ListTile(
    title: RichText(
      text: TextSpan(
          text: '${repo.author} / ',
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: DefaultTextStyle.of(context).style.fontFamily),
          children: <TextSpan>[
            TextSpan(
                text: '${repo.name}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: DefaultTextStyle.of(context).style.fontFamily))
          ]),
    ),
    subtitle: Text('${repo.description}'),
    trailing: IconButton(
      icon: Icon(Icons.launch),
      onPressed: () async {
        if (await canLaunch(repo.url)) {
          await launch(repo.url);
        }
      },
    ),
  );
}
