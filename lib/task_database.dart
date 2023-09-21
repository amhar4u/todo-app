import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Add_todo.dart';
import 'TaskClass.dart';

class TaskDatabase {
  late Database _database;
  static final table = 'tasks';

  TaskDatabase._privateConstructor();

  static final TaskDatabase instance = TaskDatabase._privateConstructor();
  bool _initialized = false; // Add this flag to track initialization.

  Future<void> initialize() async {
    if (!_initialized) {
      try {
        final databasePath = await getDatabasesPath();
        final path = join(databasePath, 'tasks.db');
        _database = await openDatabase(
          path,
          version: 1,
          onCreate: _onCreate,
        );
        _initialized = true; // Mark initialization as complete.
      } catch (e) {
        print('Error initializing database: $e');
      }
    }
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskTitle TEXT,
        category TEXT,
        date TEXT,
        description TEXT,
        status TEXT
      )
    ''');
  }

  Future<List<Task>> getTasks() async {
    if (_database == null) {
      print('Database is not initialized.');
      return [];
    }

    final List<Map<String, dynamic>> maps = await _database.query(table);
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        taskTitle: maps[i]['taskTitle'],
        category: maps[i]['category'],
        date: maps[i]['date'],
        description: maps[i]['description'],
        status: maps[i]['status'],
      );
    });
  }

  Future<int> insertTask(Task task) async {
    if (_database == null) {
      print('Database is not initialized.');
      return -1;
    }

    final id = await _database.insert(table, task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
   Future<void>deleteTask(int? index) async{
        if(_database== null){
          print('Database is empty.');
        }
        await _database.delete(table,where: 'id=?',whereArgs: [index],);
   }
   Future<void> completeTask(int? index) async{
     final updatedValue = {'status': 'completed'};
     if(_database== null){
       print('Database is empty.');
     }
     await _database.update(table,updatedValue,where:'id=?',whereArgs: [index],);
   }

  Future<int?> getCountEducational() async {
    String query = 'SELECT COUNT(*) FROM $table WHERE category="Educational"';
    List<Map<String, dynamic>> result = await _database.rawQuery(query);
    int? count = Sqflite.firstIntValue(result);
    return count;
  }
  Future<int?> getCountPersonal() async {
    String query = 'SELECT COUNT(*) FROM $table WHERE category="Personal"';
    List<Map<String, dynamic>> result = await _database.rawQuery(query);
    int? count = Sqflite.firstIntValue(result);
    return count;
  }
  Future<int?> getCountShopping() async {
    String query = 'SELECT COUNT(*) FROM $table WHERE category="Shopping"';
    List<Map<String, dynamic>> result = await _database.rawQuery(query);
    int? count = Sqflite.firstIntValue(result);
    return count;
  }


}
