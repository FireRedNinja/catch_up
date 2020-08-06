import 'dart:async';
import 'dart:collection';
import 'package:catch_up/pages/GitHub/Data/Repo.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class GitHubApiError extends Error {
  final String message;

  GitHubApiError(this.message);
}

class GitHubBloc {
  HashMap<int, Repo> _cachedRepos;
  var _repos = <Repo>[];
  static const _baseUrl = 'https://ghapi.huchen.dev/repositories';

  final _sortTypeController = StreamController<SortType>();
  final _reposSubject = BehaviorSubject<UnmodifiableListView<Repo>>();

  Stream<UnmodifiableListView<Repo>> get repos => _reposSubject.stream;
  Sink<SortType> get sortType => _sortTypeController.sink;

  GitHubBloc() {
    _sortTypeController.stream.listen((sortType) async {
      _repos.clear();
      await _getTrendingRepos(sortType);
    });
  }

  void close() {
    _sortTypeController.close();
  }

  Future<Null> _getTrendingRepos(SortType type) async {
    var partUrl;
    switch (type) {
      case SortType.today:
        partUrl = 'daily';
        break;
      case SortType.thisWeek:
        partUrl = 'weekly';
        break;
      case SortType.thisMonth:
        partUrl = 'monthly';
        break;
      default:
    }

    final url = '$_baseUrl?since=$partUrl';
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw GitHubApiError("Stories $type couldn't be fetched.");
    }
    _repos = parseTrendingRepos(response.body).toList();
    _reposSubject.add(UnmodifiableListView(_repos));
  }
}

enum SortType {
  today,
  thisWeek,
  thisMonth,
}
