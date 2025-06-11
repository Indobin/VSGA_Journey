import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vsga_app/models/akun.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    return _database ??= await _initDB('app.db');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE akun (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT,
        no_hp TEXT,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Perjalanan  (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        akun_id INTEGER,
        latitude REAL,
        longitude REAL,
        catatan TEXT,
        accelerometer_x REAL,
        accelerometer_y REAL,
        accelerometer_z REAL,
        created_at TEXT,
        FOREIGN KEY (akun_id) REFERENCES akun (id)
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

