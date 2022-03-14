import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../models/tv_table.dart';

class TvDatabaseHelper {
  static TvDatabaseHelper? _databaseHelper;
  TvDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TvDatabaseHelper() => _databaseHelper ?? TvDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tvWatchlistTable = 'tvWatchlistTable';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/tv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tvWatchlistTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vod_id INTEGER ,
        type_id INTEGER,
        type_id_1 INTEGER,
        vod_name TEXT,
        vod_en TEXT,
        vod_class TEXT,
        vod_pic TEXT,
        vod_actor TEXT,
        vod_blurb TEXT,
        vod_remarks TEXT,
        vod_area TEXT,
        vod_version TEXT,
        vod_year TEXT,
        vod_hits INTEGER,
        vod_hits_day INTEGER,
        vod_hits_week INTEGER,
        vod_hits_month INTEGER,
        vod_up INTEGER,
        vod_down INTEGER,
        vod_score TEXT,
        vod_time TEXT,
        vod_time_add TEXT,
        vod_content TEXT,
        vod_status INTEGER,
        vod_letter TEXT,
        vod_director TEXT
      );
    ''');
  }

  Future<int> insertTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tvWatchlistTable, tv.toMap());
  }

  Future<int> removeTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.delete(
      _tvWatchlistTable,
      where: 'vod_id = ?',
      whereArgs: [tv.vod_id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tvWatchlistTable,
      where: 'vod_id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvs() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tvWatchlistTable);

    return results;
  }
}
