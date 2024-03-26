import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:task_manager/bloc/todo_item/todo_item_bloc.dart';
import 'package:task_manager/domain/models/task.dart';
import 'package:task_manager/locator.dart';

class TaskView extends HookWidget {
  const TaskView({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: locator<TodoItemBloc>(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Color.fromRGBO(245, 247, 248, 0.5019607843137255),
          elevation: 5,
          title: Text(
            'Просмотр задачи',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(38, 45, 66, 1.0)
            ),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color.fromRGBO(38, 45, 66, 1.0)
              )
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(245, 247, 248, 1.0),
        body: BlocBuilder<TodoItemBloc, TodoItemState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(38, 45, 66, 1.0)
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      task.content??'Описания нет',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          color: Color.fromRGBO(38, 45, 66, 1.0)
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
