import 'package:catch_up/consts.dart';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ProductHuntError extends Error {
  final String message;

  ProductHuntError(this.message);
}

class ProductHuntBloc {
  List _posts;
  static const _baseUrl = 'https://api.producthunt.com/v2/api/graphql';
  String _tokenUrl = 'https://api.producthunt.com/v2/oauth/token';
  ValueNotifier<GraphQLClient> _client;
  String _token = '';

  ProductHuntBloc() {
    final HttpLink httpLink = HttpLink(
      uri: _baseUrl,
    );

    final AuthLink authLink = AuthLink(
      getToken: () async {
        await getToken();
        return 'Bearer $_token';
      },
    );

    final Link link = authLink.concat(httpLink);

    _client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: link,
      ),
    );
  }

  ValueNotifier<GraphQLClient> getClient() {
    return _client;
  }

  getQuery(String sortOrder) {
    String query = """
      query readPosts(\$nPosts: Int!) {
          posts(first: \$nPosts, order: $sortOrder) {
          edges {
            node {
              name
              website
              tagline
              thumbnail {
                url
              }
              commentsCount
              topics(first: 1) {
                edges {
                  node {
                    name
                  }
                }
              }
              votesCount
            }
          }
        }
      }
    """;
    return query;
  }

  Future<Null> getToken() async {
    final response = await http.post(_tokenUrl, body: {
      "client_id": "$appAPIKey",
      "client_secret": "$appAPISecret",
      "grant_type": "client_credentials"
    });
    Map<String, dynamic> res = jsonDecode(response.body);
    _token = res['access_token'];
  }

  void setPosts(List data) {
    _posts = data;
  }

  List getPosts() {
    return _posts;
  }
}
