import 'package:task_manager/domain/models/user.dart';

abstract class AuthRepository {
  Future<User?> authenticate(String email, String password);

  Future<User?> socialAuthenticate();
}