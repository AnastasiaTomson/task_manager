part of 'todo_item_bloc.dart';

@immutable
sealed class TodoItemState {}

final class TodoItemInitial extends TodoItemState {}

final class TodoItemReceived extends TodoItemState {
  final List<Task> todoList;

  TodoItemReceived(this.todoList);
}

final class TodoItemNotReceived extends TodoItemState {}

final class TaskNotAdded extends TodoItemState {}

final class TaskNotRemoved extends TodoItemState {}

final class TaskNotChangeStatus extends TodoItemState {}