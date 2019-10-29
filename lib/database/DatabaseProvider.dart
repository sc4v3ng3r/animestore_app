
import 'dart:convert' as json;

import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Database _db;
  String _DB_NAME = 'AnimeAppDB.db';
  int _CURRENT_VERSION = 2;

  static const _ID = 'id';
  static const _DATA = 'imageUrl';
  
  static const _TABLE_MY_LIST= "MY_LIST";
  static const _TABLE_ANIME_EPISODE_TRACK = "ANIME_EPISODE_TRACK";
  static const _ANIME_ID = 'animeId';
  static const _EPISODE_ID = 'episodeId';

  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DB_NAME);

    _db = await  openDatabase(path,
      version: _CURRENT_VERSION,
      onCreate: _createDataBase,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDataBase(Database db, int version) async {
    String sql = 'CREATE TABLE $_TABLE_MY_LIST '
        ' (id INTEGER PRIMARY KEY,'
        ' imageUrl TEXT)';

    return await db.execute(sql);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final String sql = 'CREATE TABLE $_TABLE_ANIME_EPISODE_TRACK '
        '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' $_ANIME_ID TEXT,'
        ' $_EPISODE_ID TEXT)';

    return await db.execute(sql);
  }

  Future<Map<String, List<String>>> loadWatchedEpisodes() async {
    var mapList = await _db.query(_TABLE_ANIME_EPISODE_TRACK);

    Map<String, List<String>> dataMap = {};

    mapList.forEach(
            (record) {
              var episodeId = record[_EPISODE_ID];
              var animeId = record[_ANIME_ID];

              if (dataMap[animeId] == null)
                dataMap.putIfAbsent(animeId, () => []);

              if(!dataMap[animeId].contains(episodeId))
                dataMap[animeId].add(episodeId);
            });

    return dataMap;
  }

  Future<int> insertWatchedEpisode(String animeId, String episodeId) async {
    return await _db.insert(_TABLE_ANIME_EPISODE_TRACK,
        {
          _ANIME_ID : animeId,
          _EPISODE_ID : episodeId
        });
  }

  Future<int> removeWatchedEpisode(String animeId, String episodeId) async {
    return await _db.delete(_TABLE_ANIME_EPISODE_TRACK,
        where: '$_ANIME_ID = ? and $_EPISODE_ID = ?',
        whereArgs: [animeId, episodeId]
    );
  }

  Future<int> removeAllWatchedEpisodes(String animeId) async {
    return await _db.delete(_TABLE_ANIME_EPISODE_TRACK,
        where: '$_ANIME_ID = ?',
        whereArgs: [animeId]
    );
  }

  Future<int> clearWatchedEpisodes() async {
    return await _db.delete(_TABLE_ANIME_EPISODE_TRACK);
  }


  Future<int> insertAnimeToList(String id, AnimeItem data) async {
    return _db.insert(_TABLE_MY_LIST,
        {_ID : id, _DATA : json.jsonEncode( dataToJson(data) ) },
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
  
  Future<int> removeAnimeFromList(String id) async {
    return _db.delete(_TABLE_MY_LIST, where: '$_ID =?', whereArgs: [id] );
  }

  Future<Map<String, AnimeItem>> loadMyAnimeList() async {
    var list = await _db.query(_TABLE_MY_LIST);
    Map<String, AnimeItem> dataMap = {};

    list.forEach(  (data) => dataMap.putIfAbsent( data[_ID].toString() ,
            () {
              Map<String, dynamic> map = Map.from(json.jsonDecode(data[_DATA]) );
              map[ID] = '${map[ID]}';
              return AnimeItem.fromJson( map );
            }  )
    );
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

  static Map<String, dynamic> dataToJson(AnimeItem item) =>
      {
        ID : int.parse(item.id),
        PAGE_URL : item.pageUrl,
        IMAGE_URL : item.imageUrl,
        TITLE : item.title,
        CC : item.closeCaptionType,
      };

}