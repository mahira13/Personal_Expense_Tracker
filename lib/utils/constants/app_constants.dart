import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
var formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  misc,
}

//database
const tableName = 'expenses';
const databaseName = 'expenses_database.db';
