part of 'todo_item_bloc.dart';

@immutable
sealed class TodoItemEvent {}

class GetTodoList extends TodoItemEvent {}

class AddTask extends TodoItemEvent {
  final String title;
  final String? content;

  AddTask(this.title, this.content);
}

class RemoveTask extends TodoItemEvent {
  final int id;

  RemoveTask(this.id);
}

class SetStatusItem extends TodoItemEvent {
  final int id;
  final bool status;

  SetStatusItem(this.id, this.status);
}