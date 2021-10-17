import 'dart:convert' as json;

import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:anime_app/model/EpisodeWatched.dart';

class DatabaseProvider {
  late Database _db;
  static const String _DB_NAME = 'AnimeAppDB.db';
  static const int _CURRENT_VERSION = 3;

  static const _ID = 'id';
  static const _DATA = 'imageUrl';

  static const _TABLE_MY_LIST = "MY_LIST";
  static const _TABLE_ANIME_EPISODE_TRACK = "ANIME_EPISODE_TRACK";
  static const _ANIME_ID = 'animeId';
  static const _EPISODE_ID = 'episodeId';
  static const _EPISODE_TITLE = 'episodeTitle';
  static const _VIEWED_AT = 'viewedAt';

  var _dbPath;
  // Sql scripts versions.

  // FOLLOWING THE CURRENT VERSION
  static const _CREATION_SCRIPTS = [
    sql1,
    sql2,
    sql3,
    sql4,
    sql5,
    sql6,
  ];

  static const _MIGRATION_SCRIPTS = [
    [
      sql2,
    ], // version 2
    [sql3, sql4, sql5, sql6], // version 3
    // version 3
  ];
  // user anime list [MY_LIST]

  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    _dbPath = join(databasesPath, _DB_NAME);

    _db = await openDatabase(
      _dbPath,
      version: _CURRENT_VERSION,
      onCreate: _createDataBase,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDataBase(Database db, int version) async {
    var exists = await databaseExists(_dbPath);
    print('ON CREATE version: $version, Exists: $exists');
    _CREATION_SCRIPTS.forEach((sql) async => await db.execute(sql));
    //return await db.execute(sql);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('On UPGRADE OLD version: $oldVersion, NEW version $newVersion');

    for (var i = oldVersion; i < newVersion; i++) {
      var scriptVector = _MIGRATION_SCRIPTS[i - 1];
      scriptVector.forEach((sql) async => await db.execute(sql));
    }
  }

  Future<List<EpisodeWatched>> loadWatchedEpisodes() async {
    var mapList = await _db.query(_TABLE_ANIME_EPISODE_TRACK);

    return mapList.map((json) => EpisodeWatched.fromJson(json)).toList();
    //return mapList;
    // Map<String, dynamic> dataMap = {};

    // mapList.forEach(
    //         (record) {
    //           var episodeId = record[_EPISODE_ID];
    //           var animeId = record[_ANIME_ID];

    //           if (dataMap[animeId] == null)
    //             dataMap.putIfAbsent(animeId, () => []);

    //           if(!dataMap[animeId].contains(episodeId))
    //             dataMap[animeId].add(episodeId);
    //         });

    // return dataMap;
  }

  Future<int> insertWatchedEpisode(EpisodeWatched episode) async {
    return await _db.insert(_TABLE_ANIME_EPISODE_TRACK, {
      _EPISODE_TITLE: episode.title,
      _EPISODE_ID: episode.id,
      _VIEWED_AT: episode.viewedAt,
    });
  }

  Future<int> removeWatchedEpisode(String episodeId) async {
    return await _db.delete(_TABLE_ANIME_EPISODE_TRACK,
        where: '$_EPISODE_ID = ?', whereArgs: [episodeId]);
  }

  Future<int> removeAllWatchedEpisodes() async {
    return await _db.delete(
      _TABLE_ANIME_EPISODE_TRACK,
    );
  }

  Future<int> clearWatchedEpisodes() async {
    return await _db.delete(_TABLE_ANIME_EPISODE_TRACK);
  }

  Future<int> clearAllMyList() => _db.delete(_TABLE_MY_LIST);

  Future<int> insertAnimeToList(String id, AnimeItem data) async {
    return _db.insert(
      _TABLE_MY_LIST,
      {_ID: id, _DATA: json.jsonEncode(dataToJson(data))},
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<int> removeAnimeFromList(String id) async {
    return _db.delete(_TABLE_MY_LIST, where: '$_ID =?', whereArgs: [id]);
  }

  Future<Map<String, AnimeItem>> loadMyAnimeList() async {
    var list = await _db.query(_TABLE_MY_LIST);
    Map<String, AnimeItem> dataMap = {};

    list.forEach((data) => dataMap.putIfAbsent(data[_ID].toString(), () {
          Map<String, dynamic> map =
              Map.from(json.jsonDecode(data[_DATA] as String));
          map[ID] = '${map[ID]}';
          return AnimeItem.fromJson(map);
        }));
    return dataMap;
  }

  void deleteDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DB_NAME);
    deleteDatabase(path);
  }

  static const ID = "id";
  static const PAGE_URL = "pageUrl";
  static const IMAGE_URL = "imageUrl";
  static const TITLE = "title";
  static const CC = "closeCaption";

  static Map<String, dynamic> dataToJson(AnimeItem item) => {
        ID: int.parse(item.id),
        PAGE_URL: item.pageUrl,
        IMAGE_URL: item.imageUrl,
        TITLE: item.title,
        CC: item.closeCaptionType,
      };

  static const sql1 = 'CREATE TABLE $_TABLE_MY_LIST '
      ' (id INTEGER PRIMARY KEY,'
      ' imageUrl TEXT)';

  static const sql2 = 'CREATE TABLE $_TABLE_ANIME_EPISODE_TRACK '
      '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $_ANIME_ID TEXT,'
      ' $_EPISODE_ID TEXT)';

  // renaming _TABLE_ANIME_EPISODE_TRACK to OLD
  static const sql3 =
      'ALTER TABLE $_TABLE_ANIME_EPISODE_TRACK RENAME TO ${_TABLE_ANIME_EPISODE_TRACK}_old';

  // defining our new  _TABLE_ANIME_EPISODE_TRACK table
  static const sql4 = 'CREATE TABLE $_TABLE_ANIME_EPISODE_TRACK '
      '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $_EPISODE_TITLE TEXT,'
      ' $_VIEWED_AT INTEGER,'
      ' $_EPISODE_ID TEXT)';

  // copying the data from OLD to the new _TABLE_ANIME_EPISODE_TRACK
  static const sql5 = 'INSERT INTO $_TABLE_ANIME_EPISODE_TRACK ($_EPISODE_ID)'
      ' SELECT $_EPISODE_ID'
      ' FROM ${_TABLE_ANIME_EPISODE_TRACK}_old';

  //removing OLD table
  static const sql6 = 'DROP TABLE ${_TABLE_ANIME_EPISODE_TRACK}_old';
}
