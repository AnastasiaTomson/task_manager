import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:task_manager/data/database/todo_list_table.dart';
import 'package:task_manager/domain/models/task.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TodoItems])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future setStatus(int id, bool status) async {
    return (update(todoItems)..where((tbl) => tbl.id.equals(id)))
        .write(TodoItemsCompanion(status: Value(status)));
  }

  Future<List<TodoItem>> getAllTodoItems() => select(todoItems).get();

  Future<int> insertNewTodoItem(String title, String? content) async {
    final companion = TodoItemsCompanion.insert(
      title: title,
      content: Value.absentIfNull(content),
    );
    return await into(todoItems).insert(companion);
  }

  Future removeTodoItem(int id) {
    return (delete(todoItems)..where((t) => t.id.equals(id))).go();
  }
}

class AppDbSingleton {
  static final AppDb _instance = AppDb();

  static AppDb get instance => _instance;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'spaceflight.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
