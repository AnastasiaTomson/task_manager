import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/bloc/authentication/authentication_bloc.dart';
import 'package:task_manager/domain/models/task.dart';
import 'package:task_manager/locator.dart';
import 'package:task_manager/views/add_task_view.dart';
import 'package:task_manager/views/authentication_view.dart';
import 'package:task_manager/views/instruction_view.dart';
import 'package:task_manager/views/task_view.dart';
import 'package:task_manager/views/todo_list_view.dart';
import 'package:task_manager/views/user_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  locator.isReady<SharedPreferences>().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AuthenticationBloc>(),
      child: MaterialApp(
        initialRoute: '/auth',
        onGenerateRoute: (settings) {
          final args = settings.arguments;
          switch (settings.name) {
            case '/todo_list': return MaterialPageRoute(builder: (_) => TodoListView());
            case '/instruction': return MaterialPageRoute(builder: (_) => InstructionView());
            case '/auth': return MaterialPageRoute(builder: (_) => AuthenticationView());
            case '/profile': return MaterialPageRoute(builder: (_) => UserView());
            case '/task': return MaterialPageRoute(builder: (_) => TaskView(task: args as Task));
            case '/add_task': return MaterialPageRoute(builder: (_) => AddTaskView());
            default: return null;
          }
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(23, 101, 203, 1.0)
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}