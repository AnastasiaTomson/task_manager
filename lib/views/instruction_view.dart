import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/bloc/todo_item/todo_item_bloc.dart';
import 'package:task_manager/locator.dart';

class InstructionView extends HookWidget {
  InstructionView({super.key});
  final prefs = locator<SharedPreferences>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 255, 251, 1.0),
      body: BlocProvider.value(
        value: locator<TodoItemBloc>()..add(GetTodoList()),
        child: BlocBuilder<TodoItemBloc, TodoItemState>(
          builder: (context, state) {
            return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/welcome.svg',
                            height: 350,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Добро пожаловать в приложение для планирования дел!',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(87, 175, 75, 1.0)
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Добавляйте задачи и отмечайте их выполнение - просто и эффективно. Давайте начнем делать ваш день более продуктивным! 🚀',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Color.fromRGBO(182, 182, 182, 1.0)
                            ),
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
                          if(!prefs.containsKey('isEntered')) {
                            prefs.setBool('isEntered', true);
                          }
                          Navigator.pushReplacementNamed(context, '/todo_list');
                        },
                        child: Text(
                          'Продолжить',
                          style: TextStyle(
                            // Основой текст жирный
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Color.fromRGBO(255, 255, 255, 1.0)
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            );
          },
        ),
      ),
    );
  }
}
