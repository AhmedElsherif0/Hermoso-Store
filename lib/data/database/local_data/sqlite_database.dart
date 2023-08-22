import 'package:hermoso_store/data/model/cart_model/cart_item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  SqliteDatabase._privateConstructor();

  static final SqliteDatabase _sqlite = SqliteDatabase._privateConstructor();

  factory SqliteDatabase() => _sqlite;

  static Database? _database;

  final String _cartTable = 'cartTable';
  String get cartTableName => _cartTable;

  Future<Database?> createDatabase() async {
    if (_database != null) return _database;
    String path = join(await getDatabasesPath(), 'Sqlite.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE $_cartTable (id INTEGER PRIMARY KEY autoincrement,
          name TEXT, price REAL, oldPrice REAL ,quantity integer,image TEXT )''');
    });
    return _database;
  }

  Future<int?> insertProduct(
      {required dynamic product, required String tableName}) async {
    Future<int>? insertedData;
    _database = await createDatabase();
    insertedData = _database?.insert(tableName, product.toMap());
    return insertedData;
  }

  Future<List<Map<String, Object?>>> readByTable(
      {required String table}) async {
    _database = await createDatabase();
    List<Map<String, Object?>> result = await _database!.query(table);
    return result;
  }

  Future<Object> readById(
      {required String table, required dynamic product}) async {
    _database = await createDatabase();
    List<Map<String, dynamic>>? result;
    if (product.id != null) {
      if (product.id.isNotEmpty) {
        result = await _database
            ?.query(table, where: 'id = ?', whereArgs: [product.id]);
      }
    } else {
      result = await _database?.query(table);
    }
    Object todos = result!.isNotEmpty
        ? result.map((item) => product.fromJson(item)).toList().asMap()
        : [];
    return todos;
  }

  Future<int?> update(
      {required dynamic product, required String tableName}) async {
    _database = await createDatabase();
    return await _database?.update(tableName, product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int?> deleteItem(
      {required int id, required String tableName}) async {
    _database = await createDatabase();
    return await _database?.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> deleteAllItems({required String tableName}) async {
    _database = await createDatabase();
    return await _database?.delete(tableName);
  }
}
