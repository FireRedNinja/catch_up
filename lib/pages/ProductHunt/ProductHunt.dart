import 'package:catch_up/CatchUpDrawer.dart';
import 'package:catch_up/pages/ProductHunt/ProductHuntBloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:collection';

class ProductHunt extends StatefulWidget {
  final ProductHuntBloc bloc;

  ProductHunt({Key key, this.bloc}) : super(key: key);

  @override
  _ProductHuntState createState() => _ProductHuntState();
}

class _ProductHuntState extends State<ProductHunt> {
  String sortValue = "RANKING";

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: widget.bloc.getClient(),
        child: CacheProvider(child: _buildScaffold(context)));
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Hunt'),
        actions: _buildActions(),
      ),
      body: RefreshIndicator(
          child: _buildFeed(context),
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 400));
            setState(() {});
          }),
      drawer: CatchUpDrawer(),
    );
  }

  Widget _buildFeed(BuildContext context) {
    return Query(
        options: QueryOptions(
          documentNode: gql(widget.bloc.getQuery(sortValue)),
          variables: {'nPosts': 10},
          pollInterval: 3600000,
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Padding(
                padding: EdgeInsets.all(20),
                child: Text(result.exception.toString()));
          }

          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          List posts = result.data['posts']['edges'];
          widget.bloc.setPosts(posts);

          return ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: widget.bloc.getPosts().length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return _buildListTile(post['node'], context);
            },
            separatorBuilder: (context, index) => Divider(),
          );
        });
  }

  List<Widget> _buildActions() {
    return <Widget>[
      PopupMenuButton<String>(
          onSelected: (String value) {
            var newValue;
            switch (value) {
              case "Featured At":
                newValue = "FEATURED_AT";
                break;
              case "Votes":
                newValue = "VOTES";
                break;
              case "Ranking":
                newValue = "RANKING";
                break;
              case "Newest":
                newValue = "NEWEST";
                break;
              default:
            }
            setState(() {
              sortValue = newValue;
            });
          },
          icon: Icon(Icons.sort),
          itemBuilder: (BuildContext context) => <String>[
                'Featured At',
                'Votes',
                'Ranking',
                'Newest'
              ]
                  .map((String value) =>
                      PopupMenuItem<String>(value: value, child: Text(value)))
                  .toList()),
      PopupMenuButton(
          onSelected: (String value) async {
            await launch("https://www.producthunt.com/");
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: "Go to site",
                  child: Text('Go To ProductHunt'),
                )
              ]),
    ];
  }

  Widget _buildListTile(
      LinkedHashMap<String, dynamic> post, BuildContext context) {
    final topic = post['topics']['edges'].length > 0
        ? post['topics']['edges'][0]['node']['name']
        : '';
    return ListTile(
      leading: AspectRatio(
        aspectRatio: 1,
        child: Image(image: NetworkImage("${post['thumbnail']['url']}")),
      ),
      title: Text(
        '${post['name']}',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '${post['tagline']}',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          Row(children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.black54,
                      size: 16,
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                    Text("${post['commentsCount']}",
                        style: TextStyle(color: Colors.black54)),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
            Text("$topic", style: TextStyle(color: Colors.black54))
          ]),
        ],
      ),
      trailing: Column(
        children: [
          Icon(Icons.arrow_drop_up),
          Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          Text("${post['votesCount']}")
        ],
      ),
    );
  }
}
