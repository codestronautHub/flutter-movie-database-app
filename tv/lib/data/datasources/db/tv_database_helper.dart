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
        firstAirDate TEXT,
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        voteAverage DOUBLE
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
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tvWatchlistTable,
      where: 'id = ?',
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
