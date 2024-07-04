import 'package:personal_expense_tracker/data/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqf;

import '../../utils/constants/app_constants.dart';

class DatabaseService {

  String? _dbPath;
  sqf.Database? _db;
  Future<sqf.Database?> get database async {
    if (_db != null) return _db;

    _db = await _initDatabase();
    return _db;
  }

// open the database
  _initDatabase() async {
    _dbPath = join(await sqf.getDatabasesPath(), databaseName);

    final dbAlreadyExists = await sqf.databaseExists(_dbPath ?? "");
    if (dbAlreadyExists) {
      _db = await sqf.openDatabase(_dbPath ?? "", version: 1);
      return _db;
    }
  }

  Future<List<ExpenseModel>> loadTransactions() async {
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
                'CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT, amount TEXT, date INTEGER, category TEXT)');
          },
        );
        return [];
      }
    } catch (e) {
      throw Exception('Unable to create/get database.');
    }
  }

  Future<List<ExpenseModel>> getAllTransactions() async {
    try {
      final List<Map> tList = await _db!.query(tableName, orderBy: 'date');
      final List<ExpenseModel> transactions =
          tList.map((tMap) => ExpenseModel.fromMap(tMap)).toList();
      return List.from(transactions.reversed);
    } catch (e) {
      print(e);
      throw Exception('Unable to get transactions.');
    }
  }

  Future<List<ExpenseModel>> addTransaction({required ExpenseModel addT}) async {
    _db = await database;
    try {
      await _db!.insert(tableName, addT.toMap(),
          conflictAlgorithm: sqf.ConflictAlgorithm.replace);

      return await getAllTransactions();
    } catch (e) {
      print(e);
      throw Exception('Unable to get add transaction.');
    }
  }

  Future<List<ExpenseModel>> removeTransaction({required String expenseId}) async {
    _db = await database;
    try {
      await _db!.delete(tableName, where: 'id = ?', whereArgs: [expenseId]);
      return await getAllTransactions();
    } catch (e) {
      throw Exception('Unable to get delete transaction.');
    }
  }

  Future<List<ExpenseModel>> updateTransaction(
      {required ExpenseModel transaction}) async {
    _db = await database;
    try {
    await _db!.update(tableName, transaction.toMap(),
          where: 'id = ?', whereArgs: [transaction.id]);

      return await getAllTransactions();
    } catch (e) {
  
      throw Exception('Unable to update transaction.');
    }
  }
}
