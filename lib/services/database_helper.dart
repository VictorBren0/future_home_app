import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/residence_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'residence.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE residences (
        id TEXT PRIMARY KEY,
        type_residence TEXT,
        address TEXT,
        neighborhood TEXT,
        rt_address INTEGER,
        nr_rooms TEXT,
        nr_bathrooms TEXT,
        nr_garages TEXT,
        fl_pool TEXT,
        rt_details_residence INTEGER,
        nm_seller TEXT,
        phone_seller TEXT,
        price REAL,
        rt_seller INTEGER,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> insertResidence(ResidenceModel residence) async {
    final db = await database;
    await db.insert('residences', residence.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ResidenceModel>> getResidences() async {
    final db = await database;
    final maps = await db.query('residences');
    return maps.map((map) => ResidenceModel.fromMap(map)).toList();
  }

  Future<ResidenceModel?> getResidenceById(String id) async {
    final db = await database;
    final maps = await db.query('residences', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ResidenceModel.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateResidence(ResidenceModel residence) async {
    final db = await database;
    await db.update(
      'residences',
      residence.toMap(),
      where: 'id = ?',
      whereArgs: [residence.id],
    );
  }

  Future<void> deleteResidence(String id) async {
    final db = await database;
    await db.delete('residences', where: 'id = ?', whereArgs: [id]);
  }
}
