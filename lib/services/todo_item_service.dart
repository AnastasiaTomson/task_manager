import 'package:task_manager/data/database/app_database.dart';
import 'package:task_manager/domain/models/task.dart';

class TodoItemService {
  final db = AppDbSingleton.instance;

  Future<List<Task>> getTodoList() async {
    final todoList = await db.getAllTodoItems();
    return List.generate(todoList.length, (index) => Task.fromJson(todoList[index].toJson()));
  }

  Future<int> addTask(String title, String? content) async {
    return await db.insertNewTodoItem(title, content);
  }

  Future<bool> removeTask(int id) async {
    int response = await db.removeTodoItem(id);
    return response != 0;
  }

  Future<bool> setStatusItem(int id, bool status) async {
    int response = await db.setStatus(id, status);
    return response != 0;
  }
}