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
          title: Text(
            'Добавление задачи',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: titleNameController,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color.fromRGBO(55, 56, 55, 1.0)
                            ),
                            decoration: InputDecoration(
                              fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(229, 235, 237, 1),),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(37, 193, 101, 1.0),),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(255, 45, 45, 0.3)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(229, 235, 237, 1),),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              labelText: 'Название',
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Поле не может быть пустым';
                              }
                              return null;
                            },
                            onChanged: (text) {}
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: contentNameController,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color.fromRGBO(55, 56, 55, 1.0)
                            ),
                            maxLines: 4,
                            decoration: InputDecoration(
                              fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(229, 235, 237, 1),),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(37, 193, 101, 1.0),),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(255, 45, 45, 0.3)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Color.fromRGBO(229, 235, 237, 1),),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              labelText: 'Описание',
                              alignLabelWithHint: true,
                            ),
                            onChanged: (text) {}
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.maxFinite,
                          child: MaterialButton(
                            height: 48,
                            color: Color.fromRGBO(37, 193, 101, 1.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            onPressed: () {
                              if(formKey.currentState!.validate()) {
                                BlocProvider.of<TodoItemBloc>(context).add(AddTask(titleNameController.text, contentNameController.text.isEmpty ? null : contentNameController.text));
                              }
                            },
                            child: Text(
                              'Добавить',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ],
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
