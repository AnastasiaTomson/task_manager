import 'package:flutter/material.dart';
import 'package:task_manager/locator.dart';
import 'package:task_manager/views/add_task_view.dart';
import 'package:task_manager/views/todo_list_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) {
          return TodoListView();
        },
        '/add_task' : (BuildContext context) {
          return AddTaskView();
        }
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(37, 193, 101, 1.0)),
        useMaterial3: true,
      ),
    );
  }
}