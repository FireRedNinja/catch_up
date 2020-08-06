import 'dart:convert' as json;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:catch_up/pages/serializers.dart';

part 'Item.g.dart';

abstract class Item implements Built<Item, ItemBuilder> {
  static Serializer<Item> get serializer => _$itemSerializer;

  int get id;

  @nullable
  bool get deleted;

  String get type; // "job", "story", "comment", "poll", or "pollopt".

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Item._();

  factory Item([updates(ItemBuilder b)]) = _$Item;
}

List<int> parseTopStories(String jsonStr) {
  final parsed = json.jsonDecode(jsonStr);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Item parseItem(String jsonStr) {
  final parsed = json.jsonDecode(jsonStr);
  Item item = standardSerializers.deserializeWith(Item.serializer, parsed);
  return item;
}
