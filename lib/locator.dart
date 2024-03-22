import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/bloc/todo_item/todo_item_bloc.dart';
import 'package:task_manager/domain/interface/todo_item_repository.dart';
import 'package:task_manager/repository/todo_item_repository_impl.dart';
import 'package:task_manager/services/todo_item_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Storages
  locator.registerLazySingletonAsync(() async => await SharedPreferences.getInstance());
  locator.registerLazySingleton(() => FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true)
  ));

  // Services
  locator.registerLazySingleton(() => TodoItemService());

  // Repositories
  locator.registerLazySingleton<TodoItemRepository>(() => TodoItemRepositoryImpl());

  // Bloc
  locator.registerLazySingleton(() => TodoItemBloc());
}