// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Repo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Repo> _$repoSerializer = new _$RepoSerializer();

class _$RepoSerializer implements StructuredSerializer<Repo> {
  @override
  final Iterable<Type> types = const [Repo, _$Repo];
  @override
  final String wireName = 'Repo';

  @override
  Iterable<Object> serialize(Serializers serializers, Repo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'avatar',
      serializers.serialize(object.avatar,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'stars',
      serializers.serialize(object.stars, specifiedType: const FullType(int)),
      'forks',
      serializers.serialize(object.forks, specifiedType: const FullType(int)),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.language != null) {
      result
        ..add('language')
        ..add(serializers.serialize(object.language,
            specifiedType: const FullType(String)));
    }
    if (object.languageColor != null) {
      result
        ..add('languageColor')
        ..add(serializers.serialize(object.languageColor,
            specifiedType: const FullType(String)));
    }
    if (object.currentPeriodStars != null) {
      result
        ..add('currentPeriodStars')
        ..add(serializers.serialize(object.currentPeriodStars,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Repo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RepoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar':
          result.avatar = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'language':
          result.language = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'languageColor':
          result.languageColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'stars':
          result.stars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'forks':
          result.forks = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'currentPeriodStars':
          result.currentPeriodStars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Repo extends Repo {
  @override
  final String author;
  @override
  final String name;
  @override
  final String avatar;
  @override
  final String url;
  @override
  final String description;
  @override
  final String language;
  @override
  final String languageColor;
  @override
  final int stars;
  @override
  final int forks;
  @override
  final int currentPeriodStars;

  factory _$Repo([void Function(RepoBuilder) updates]) =>
      (new RepoBuilder()..update(updates)).build();

  _$Repo._(
      {this.author,
      this.name,
      this.avatar,
      this.url,
      this.description,
      this.language,
      this.languageColor,
      this.stars,
      this.forks,
      this.currentPeriodStars})
      : super._() {
    if (author == null) {
      throw new BuiltValueNullFieldError('Repo', 'author');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Repo', 'name');
    }
    if (avatar == null) {
      throw new BuiltValueNullFieldError('Repo', 'avatar');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('Repo', 'url');
    }
    if (stars == null) {
      throw new BuiltValueNullFieldError('Repo', 'stars');
    }
    if (forks == null) {
      throw new BuiltValueNullFieldError('Repo', 'forks');
    }
  }

  @override
  Repo rebuild(void Function(RepoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RepoBuilder toBuilder() => new RepoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Repo &&
        author == other.author &&
        name == other.name &&
        avatar == other.avatar &&
        url == other.url &&
        description == other.description &&
        language == other.language &&
        languageColor == other.languageColor &&
        stars == other.stars &&
        forks == other.forks &&
        currentPeriodStars == other.currentPeriodStars;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, author.hashCode), name.hashCode),
                                    avatar.hashCode),
                                url.hashCode),
                            description.hashCode),
                        language.hashCode),
                    languageColor.hashCode),
                stars.hashCode),
            forks.hashCode),
        currentPeriodStars.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Repo')
          ..add('author', author)
          ..add('name', name)
          ..add('avatar', avatar)
          ..add('url', url)
          ..add('description', description)
          ..add('language', language)
          ..add('languageColor', languageColor)
          ..add('stars', stars)
          ..add('forks', forks)
          ..add('currentPeriodStars', currentPeriodStars))
        .toString();
  }
}

class RepoBuilder implements Builder<Repo, RepoBuilder> {
  _$Repo _$v;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _avatar;
  String get avatar => _$this._avatar;
  set avatar(String avatar) => _$this._avatar = avatar;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _language;
  String get language => _$this._language;
  set language(String language) => _$this._language = language;

  String _languageColor;
  String get languageColor => _$this._languageColor;
  set languageColor(String languageColor) =>
      _$this._languageColor = languageColor;

  int _stars;
  int get stars => _$this._stars;
  set stars(int stars) => _$this._stars = stars;

  int _forks;
  int get forks => _$this._forks;
  set forks(int forks) => _$this._forks = forks;

  int _currentPeriodStars;
  int get currentPeriodStars => _$this._currentPeriodStars;
  set currentPeriodStars(int currentPeriodStars) =>
      _$this._currentPeriodStars = currentPeriodStars;

  RepoBuilder();

  RepoBuilder get _$this {
    if (_$v != null) {
      _author = _$v.author;
      _name = _$v.name;
      _avatar = _$v.avatar;
      _url = _$v.url;
      _description = _$v.description;
      _language = _$v.language;
      _languageColor = _$v.languageColor;
      _stars = _$v.stars;
      _forks = _$v.forks;
      _currentPeriodStars = _$v.currentPeriodStars;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Repo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Repo;
  }

  @override
  void update(void Function(RepoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Repo build() {
    final _$result = _$v ??
        new _$Repo._(
            author: author,
            name: name,
            avatar: avatar,
            url: url,
            description: description,
            language: language,
            languageColor: languageColor,
            stars: stars,
            forks: forks,
            currentPeriodStars: currentPeriodStars);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
