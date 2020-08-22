import 'package:catch_up/consts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class ProductHuntError extends Error {
  final String message;

  ProductHuntError(this.message);
}

class ProductHuntBloc {
  var _pages = [];
  static const _baseUrl = 'https://api.producthunt.com/v2/api/graphql';
  ValueNotifier<GraphQLClient> _client;

  ProductHuntBloc() {
    final HttpLink httpLink = HttpLink(
      uri: _baseUrl,
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $productHuntApiToken',
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

  getQuery() {
    String query = """
      query readPosts(\$nPosts: Int!) {
          posts(first: \$nPosts) {
          edges {
            node {
              name
              website
              description
            }
          }
        }
      }
    """;
    return query;
  }
}
