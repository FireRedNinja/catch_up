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
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.bloc.getClient(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Hunt'),
          // actions: [], TODO: Add sorting options
        ),
        body: Query(
            options: QueryOptions(
              documentNode: gql(widget.bloc.getQuery()),
              variables: {'nPosts': 10},
              pollInterval: 3600000,
            ),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.loading) {
                return Center(child: CircularProgressIndicator());
              }

              List posts = result.data['posts']['edges'];

              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return _buildListTile(post['node'], context);
                },
                separatorBuilder: (context, index) => Divider(),
              );
            }),
        drawer: CatchUpDrawer(),
      ),
    );
  }
}

Widget _buildListTile(
    LinkedHashMap<String, dynamic> post, BuildContext context) {
  return ListTile(
    title: Text('${post['name']}'),
    subtitle: Text('${post['description']}'),
    trailing: IconButton(
      icon: Icon(Icons.launch),
      onPressed: () async {
        if (await canLaunch("${post['website']}")) {
          await launch("${post['website']}");
        }
      },
    ),
  );
}
