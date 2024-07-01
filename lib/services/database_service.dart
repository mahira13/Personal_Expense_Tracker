import 'package:personal_expense_tracker/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqf;

class ExpenseRepository {
  static const _tableName = 'expenses';
  String? _dbPath;
  sqf.Database? _db;
  Future<sqf.Database?> get database async {
    if (_db != null) return _db;

    _db = await _initDatabase();
    return _db;
  }

// open the database
  _initDatabase() async {
    _dbPath = join(await sqf.getDatabasesPath(), 'expenses_database.db');

    final dbAlreadyExists = await sqf.databaseExists(_dbPath ?? "");
    if (dbAlreadyExists) {
      _db = await sqf.openDatabase(_dbPath ?? "", version: 1);
      return _db;
    }
  }

  Future<List<Expense>> loadTransactions() async {
    _dbPath = join(await sqf.getDatabasesPath(), 'expenses_database.db');
    try {
      final dbAlreadyExists = await sqf.databaseExists(_dbPath ?? "");
      if (dbAlreadyExists) {
        _db = await sqf.openDatabase(_dbPath ?? "", version: 1);
        return await getAllTransactions();
      } else {
        _db = await sqf.openDatabase(
          _dbPath ?? "",
          version: 1,
          onCreate: (db, version) {
            return db.execute(
                'CREATE TABLE $_tableName(id TEXT PRIMARY KEY, title TEXT, amount TEXT, date INTEGER, category TEXT)');
          },
        );
        return [];
      }
    } catch (e) {
      throw Exception('Unable to create/get database.');
    }
  }

  Future<List<Expense>> getAllTransactions() async {
    try {
      final List<Map> tList = await _db!.query(_tableName, orderBy: 'date');
      final List<Expense> transactions =
          tList.map((tMap) => Expense.fromMap(tMap)).toList();
      return List.from(transactions.reversed);
    } catch (e) {
      print(e);
      throw Exception('Unable to get transactions.');
    }
  }

  Future<List<Expense>> addTransaction({required Expense addT}) async {
    _db = await database;
    try {
      await _db!.insert(_tableName, addT.toMap(),
          conflictAlgorithm: sqf.ConflictAlgorithm.replace);

      return await getAllTransactions();
    } catch (e) {
      print(e);
      throw Exception('Unable to get add transaction.');
    }
  }

  Future<List<Expense>> removeTransaction({required String expenseId}) async {
    _db = await database;
    try {
      await _db!.delete(_tableName, where: 'id = ?', whereArgs: [expenseId]);
      return await getAllTransactions();
    } catch (e) {
      throw Exception('Unable to get delete transaction.');
    }
  }

  Future<List<Expense>> updateTransaction(
      {required Expense transaction}) async {
    _db = await database;
    try {
    await _db!.update(_tableName, transaction.toMap(),
          where: 'id = ?', whereArgs: [transaction.id]);

      return await getAllTransactions();
    } catch (e) {
  
      throw Exception('Unable to update transaction.');
    }
  }
}
