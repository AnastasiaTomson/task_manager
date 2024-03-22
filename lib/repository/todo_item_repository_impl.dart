import 'package:task_manager/domain/interface/todo_item_repository.dart';
import 'package:task_manager/domain/models/task.dart';
import 'package:task_manager/locator.dart';
import 'package:task_manager/services/todo_item_service.dart';

class TodoItemRepositoryImpl implements TodoItemRepository{
  final TodoItemService todoItemService = locator<TodoItemService>();

  @override
  Future<int> addItem(String title, String? content) async {
    try {
      return todoItemService.addTask(title, content);
    }
    catch (ex) {
      return 0;
    }
  }

  @override
  Future<List<Task>> getItems() async {
    try {
      return todoItemService.getTodoList();
    }
    catch (ex) {
      return [];
    }
  }

  @override
  Future<bool> setStatusItem(int id, bool status) async {
    try {
      return todoItemService.setStatusItem(id, status);
    }
    catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> removeItem(int id) async {
    try {
      return todoItemService.removeTask(id);
    }
    catch (ex) {
      return false;
    }
  }

}