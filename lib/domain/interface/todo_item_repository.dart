import 'package:task_manager/domain/models/task.dart';

abstract class TodoItemRepository{
  Future<List<Task>> getItems();
  Future<int> addItem(String title, String? content);
  Future<bool> removeItem(int id);
  Future<bool> setStatusItem(int id, bool status);
}