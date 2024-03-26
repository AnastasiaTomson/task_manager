import 'package:task_manager/domain/interface/auth_repository.dart';
import 'package:task_manager/domain/models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> authenticate(String email, String password) async {
    Future.delayed(Duration(seconds: 1));
    if(email == 'example@sample.com' && password == '5') {
      return User.fromJson({'id': 1, 'email': email, 'firstName': 'Анастасия', 'lastName': 'Жмурко', 'phone': '+79787013102', 'avatar': 'https://sun9-68.userapi.com/impg/iF5nHK7QusN39qORmAv2aGOOkVfnLQX1-bRBKw/jo96ZtU8C9E.jpg?size=645x1147&quality=95&sign=1283aa0a448f450b4aee4b52a75475fd&type=album'});
    }else{
      return null;
    }
  }

  @override
  Future<User?> socialAuthenticate() async {
    Future.delayed(Duration(seconds: 2));
    return User.fromJson({'id': 1, 'email': 'example@sample.com', 'firstName': 'Анастасия', 'lastName': 'Жмурко', 'phone': '+79787013102', 'avatar': 'https://sun9-68.userapi.com/impg/iF5nHK7QusN39qORmAv2aGOOkVfnLQX1-bRBKw/jo96ZtU8C9E.jpg?size=645x1147&quality=95&sign=1283aa0a448f450b4aee4b52a75475fd&type=album'});
  }
}
