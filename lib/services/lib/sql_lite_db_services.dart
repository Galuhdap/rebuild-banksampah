import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final String _databaseName = 'favor.db';

  final int _databaseversion = 1;

  final String table1 = 'fava';


  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

   Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/$_databaseName';
    return await openDatabase(
      path,
      version: _databaseversion,
      onCreate: _onCreate,
    );
  }


  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $table1 (id INTEGER PRIMARY KEY, id_fav TEXT NULL, stock INTEGER NULL)''');
  }
}