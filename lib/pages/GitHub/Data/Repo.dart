import 'dart:convert' as json;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:catch_up/pages/serializers.dart';

part 'Repo.g.dart';

abstract class Repo implements Built<Repo, RepoBuilder> {
  static Serializer<Repo> get serializer => _$repoSerializer;

  String get author;
  String get name;
  String get avatar;
  String get url;
  @nullable
  String get description;
  @nullable
  String get language;
  @nullable
  String get languageColor;
  int get stars;
  int get forks;
  @nullable
  int get currentPeriodStars;

  Repo._();

  factory Repo([updates(RepoBuilder b)]) = _$Repo;
}

List<Repo> parseTrendingRepos(String jsonStr) {
  final parsed = json.jsonDecode(jsonStr);
  List<Repo> repos = <Repo>[];
  for (var repo in parsed) {
    repos.add(standardSerializers.deserializeWith(Repo.serializer, repo));
  }
  return repos;
}
