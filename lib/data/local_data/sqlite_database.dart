import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  SqliteDatabase._privateConstructor();

  static final SqliteDatabase _sqlite = SqliteDatabase._privateConstructor();

  factory SqliteDatabase() => _sqlite;

  static Database? _database;

  final String _cartTable = 'cartTable';

  Future<Database?> createDatabase() async {
    if (_database != null) return _database;
    String path = join(await getDatabasesPath(), 'Sqlite.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE $_cartTable (id INTEGER PRIMARY KEY autoincrement,
          name TEXT, price REAL, old_price REAL ,quantity integer,image TEXT )''');
    });
    return _database;
  }

  Future<int?> insertProduct(
      {required dynamic product, required String tableName}) async {
    _database = await createDatabase();
    return _database?.insert(tableName, product);
  }

  Future<List?>? readTable({required String table}) async {
    _database = await createDatabase();
    return _database?.query(table);
  }

  Future<int> update(
      {required dynamic product, required String tableName}) async {
    _database = await createDatabase();
    return await _database!.update(tableName, product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int?> deleteProduct(
      {required int id, required String tableName}) async {
    _database = await createDatabase();
    return await _database?.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> deleteAllProduct({required String tableName}) async {
    _database = await createDatabase();
    return await _database?.delete(tableName);
  }
}
