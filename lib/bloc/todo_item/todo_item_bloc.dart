import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/domain/interface/todo_item_repository.dart';
import 'package:task_manager/domain/models/task.dart';
import 'package:task_manager/locator.dart';

part 'todo_item_event.dart';
part 'todo_item_state.dart';

class TodoItemBloc extends Bloc<TodoItemEvent, TodoItemState> {
  TodoItemRepository todoItemRepository = locator<TodoItemRepository>();

  TodoItemBloc() : super(TodoItemInitial()) {
    on<GetTodoList>((event, emit) async {
      List<Task> todoList = await todoItemRepository.getItems();
      todoList.isNotEmpty ? emit(TodoItemReceived(todoList)) : emit(TodoItemNotReceived());
    });
    on<AddTask>((event, emit) async {
      int taskId = await todoItemRepository.addItem(event.title, event.content);
      if(taskId != 0) {
        List<Task> todoList = await todoItemRepository.getItems();
        todoList.isNotEmpty ? emit(TodoItemReceived(todoList)) : emit(
            TodoItemNotReceived());
      }else{
        emit(TaskNotAdded());
      }
    });
    on<RemoveTask>((event, emit) async {
      bool isRemoved = await todoItemRepository.removeItem(event.id);
      if(isRemoved) {
        List<Task> todoList = await todoItemRepository.getItems();
        todoList.isNotEmpty
            ? emit(TodoItemReceived(todoList))
            : emit(TodoItemNotReceived());
      }else{
        emit(TaskNotRemoved());
      }
    });

    on<SetStatusItem>((event, emit) async {
      bool isChanged = await todoItemRepository.setStatusItem(event.id, event.status);
      if(isChanged) {
        List<Task> todoList = await todoItemRepository.getItems();
        todoList.isNotEmpty
            ? emit(TodoItemReceived(todoList))
            : emit(TodoItemNotReceived());
      }else{
        emit(TaskNotChangeStatus());
      }
    });
  }
}
