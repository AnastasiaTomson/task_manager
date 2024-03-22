import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/bloc/todo_item/todo_item_bloc.dart';
import 'package:task_manager/locator.dart';

class TodoListView extends HookWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Список задач',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white
          ),
        ),
        backgroundColor: Color.fromRGBO(37, 193, 101, 1.0),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(251, 255, 251, 1.0),
      body: BlocProvider.value(
        value: locator<TodoItemBloc>()..add(GetTodoList()),
        child: BlocBuilder<TodoItemBloc, TodoItemState>(
          builder: (context, state) {
            if (state is TodoItemReceived) {
              return ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(UniqueKey().toString()),
                      onDismissed: (direction) {
                        BlocProvider.of<TodoItemBloc>(context).add(RemoveTask(state.todoList[index].id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color.fromRGBO(
                                37, 193, 101, 1.0),
                            duration: Duration(seconds: 1),
                            content: Text(
                              'Задача удалена',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),

                            )
                          )
                        );
                      },
                      background: Container(color: Color.fromRGBO(255, 0, 0, 0.1)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(236, 236, 236, 1.0)
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.todoList[index].title,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(55, 56, 55, 1.0)
                                  ),
                                ),
                                if(state.todoList[index].content != null)
                                  Text(
                                    state.todoList[index].content!,
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromRGBO(182, 182, 182, 1.0),
                                    ),
                                  )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<TodoItemBloc>(context).add(SetStatusItem(state.todoList[index].id, !state.todoList[index].status));
                              },
                              child: AnimatedContainer(
                                height: 20,
                                width: 20,
                                duration: Duration(microseconds: 500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(6),
                                    color: state.todoList[index].status
                                        ? Color.fromRGBO(37, 193, 101, 1.0)
                                        : Color.fromRGBO(245, 245, 245, 1.0),
                                    border: Border.all(
                                      width: 1.5,
                                      color: state.todoList[index].status
                                          ? Color.fromRGBO(37, 193, 101, 1.0)
                                          : Color.fromRGBO(182, 182, 182, 1.0),
                                    )),
                                child: state.todoList[index].status
                                    ? Icon(
                                  Icons.done_rounded,
                                  size: 14,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 10),
                  itemCount: state.todoList.length
              );
            }
            else {
              return Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/task.svg',
                        height: 350,
                      ),
                      Text(
                        'Задачи еще не добавлены. \nСкорее добавляй и приступай к выполнению!)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Color.fromRGBO(182, 182, 182, 1.0)
                        ),
                      ),
                    ],
                  ),
                )
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_task');
        },
        backgroundColor: Color.fromRGBO(37, 193, 101, 1.0),
        elevation: 0,
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
