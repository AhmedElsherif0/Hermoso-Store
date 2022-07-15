import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  SqliteDatabase._privateConstructor();

  static final SqliteDatabase _sqlite = SqliteDatabase._privateConstructor();

  factory SqliteDatabase() => _sqlite;

  static Database? _database;

  Future<Database?> createDatabase() async {
    if (_database != null) _database;
    String path = join(await getDatabasesPath(), 'Sqlite.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE products (id INTEGER PRIMARY KEY autoincrement,
          title TEXT,image TEXT, price REAL, oldPrice REAL,description varchar(255) )''');
    });
    return _database;
  }

  Future<int?> createProduct({required dynamic product}) async {
    _database = await createDatabase();
    return _database?.insert('products', product.toMap());
  }

  Future<List?>? readTable({required String table}) async {
    _database = await createDatabase();
    return _database?.query(table);
  }

  Future<int> update({required dynamic product}) async {
    _database = await createDatabase();
    return await _database!.update('products', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int?> deleteProduct({required int id}) async {
    _database = await createDatabase();
    return await _database
        ?.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> deleteAllProduct({required String tableName}) async {
    _database = await createDatabase();
    return await _database?.delete(tableName);
  }
}
