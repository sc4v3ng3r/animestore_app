
import 'dart:convert' as json;

import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Database _db;
  String _DB_NAME = 'AnimeAppDB.db';
  int _CURRENT_VERSION = 1;

  static const _ID = 'id';
  static const _DATA = 'imageUrl';
  
  static const _TABLE_MY_LIST= "MY_LIST";
  
  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DB_NAME);

    _db = await  openDatabase(path,
      version: _CURRENT_VERSION,
      onCreate: _createDataBase,
    );
  }

  Future<void> _createDataBase(Database db, int version) async {
    final String sql = 'CREATE TABLE $_TABLE_MY_LIST '
        ' (id INTEGER PRIMARY KEY,'
        ' imageUrl TEXT)';

    return await db.execute(sql);
  }
  
  Future<int> insert(String id, AnimeItem data) async {
    return _db.insert(_TABLE_MY_LIST,
        {_ID : id, _DATA : json.jsonEncode( dataToJson(data) ) },
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
  
  Future<int> remove(String id) async {
    return _db.delete(_TABLE_MY_LIST, where: '$_ID =?', whereArgs: [id] );
  }

  Future<Map<String, AnimeItem>> load() async {
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