import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:task_manager/bloc/todo_item/todo_item_bloc.dart';
import 'package:task_manager/locator.dart';

class AddTaskView extends HookWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleNameController = useTextEditingController();
    final contentNameController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider.value(
      value: locator<TodoItemBloc>(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Color.fromRGBO(245, 247, 248, 0.5019607843137255),
          elevation: 5,
          title: Text(
            'Добавление задачи',
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
        body: BlocConsumer<TodoItemBloc, TodoItemState>(
          listener: (context, state) {
            if(state is TodoItemReceived) {
              Navigator.pop(context);
            }
            if(state is TaskNotAdded) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                elevation: 0.0,
                margin: EdgeInsets.all(16),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                backgroundColor: Color.fromRGBO(
                    235, 115, 115, 1),
                content: Text(
                  'Не удалось добавить задачу',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.redAccent
                  ),
                ),
              ));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 4),
                          child: Text(
                            'Название',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(38, 45, 66, 1.0)
                            ),
                          ),
                        ),
                        TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: titleNameController,
                            style: TextStyle(
                              // Основой текст
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Color.fromRGBO(38, 45, 66, 1)
                            ),
                            decoration: InputDecoration(
                              fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                              filled: true,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color.fromRGBO(229, 235, 237, 1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color.fromRGBO(229, 235, 237, 1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            cursorColor: Color.fromRGBO(38, 45, 66, 0.5),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Поле не может быть пустым';
                              }
                              return null;
                            },
                            onChanged: (text) {}
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 4),
                          child: Text(
                            'Описание',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(38, 45, 66, 1.0)
                            ),
                          ),
                        ),
                        TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: contentNameController,
                            maxLines: 4,
                            style: TextStyle(
                              // Основой текст
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Color.fromRGBO(38, 45, 66, 1)
                            ),
                            decoration: InputDecoration(
                              fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                              filled: true,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color.fromRGBO(229, 235, 237, 1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color.fromRGBO(229, 235, 237, 1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            cursorColor: Color.fromRGBO(38, 45, 66, 0.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: MaterialButton(
                      height: 48,
                      color: Color.fromRGBO(23, 101, 203, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          BlocProvider.of<TodoItemBloc>(context).add(AddTask(titleNameController.text, contentNameController.text.isEmpty ? null : contentNameController.text));
                        }
                      },
                      child: Text(
                        'Сохранить',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1.0)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
