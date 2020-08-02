import 'dart:collection';
import 'dart:async';

import 'package:catch_up/pages/HackerNews/Data/Item.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class HackerNewsApiError extends Error {
  final String message;

  HackerNewsApiError(this.message);
}

class HackerNewsBloc {
  HashMap<int, Item> _cachedItems;
  var _items = <Item>[];
  List<int> _ids = <int>[];
  static const _baseUrl = 'https://hacker-news.firebaseio.com/v0/';

  final _itemsSubject = BehaviorSubject<UnmodifiableListView<Item>>();
  final _storiesTypeController = StreamController<StoriesType>();
  final _isLoadingSubject = BehaviorSubject<bool>();

  Stream<UnmodifiableListView<Item>> get items => _itemsSubject.stream;
  Sink<StoriesType> get storiesType => _storiesTypeController.sink;
  Stream<bool> get isLoading => _isLoadingSubject.stream;

  HackerNewsBloc() {
    _cachedItems = HashMap<int, Item>();

    _storiesTypeController.stream.listen((storiesType) async {
      _items.clear();
      await _getIds(storiesType);
      await getItemsAndUpdate(0, 10);
    });
  }

  void close() {
    _storiesTypeController.close();
  }

  Future<Null> _getIds(StoriesType type) async {
    var partUrl;
    switch (type) {
      case StoriesType.topStories:
        partUrl = 'top';
        break;
      case StoriesType.newStories:
        partUrl = 'new';
        break;
      case StoriesType.bestStories:
        partUrl = 'best';
        break;
      default:
    }
    final url = '$_baseUrl${partUrl}stories.json';
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw HackerNewsApiError("Stories $type couldn't be fetched.");
    }
    _ids = parseTopStories(response.body).toList();
  }

  Future<void> getItemsAndUpdate(int startIndex, int noOfItems) async {
    _isLoadingSubject.add(true);
    await _updateItems(_ids.sublist(startIndex, startIndex + noOfItems));
    _itemsSubject.add(UnmodifiableListView(_items));
    _isLoadingSubject.add(false);
  }

  Future<Null> _updateItems(List<int> itemIds) async {
    final futureItems = itemIds.map((id) => _getItem(id));
    final items = await Future.wait(futureItems);
    _items = _items + items;
  }

  Future<Item> _getItem(int id) async {
    if (!_cachedItems.containsKey(id)) {
      final itemUrl = '${_baseUrl}item/$id.json';
      final itemRes = await http.get(itemUrl);
      if (itemRes.statusCode == 200) {
        _cachedItems[id] = parseItem(itemRes.body);
      } else {
        throw HackerNewsApiError("Item $id couldn't be fetched.");
      }
    }
    return _cachedItems[id];
  }
}

enum StoriesType {
  topStories,
  newStories,
  bestStories,
}
