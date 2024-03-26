import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/domain/interface/auth_repository.dart';
import 'package:task_manager/domain/models/user.dart';
import 'package:task_manager/locator.dart';
import 'package:task_manager/repository/auth_repository_impl.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthRepository authRepository = locator<AuthRepository>();
  FlutterSecureStorage storage = locator<FlutterSecureStorage>();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<Authenticate>((event, emit) async {
      User? user = await authRepository.authenticate(event.email, event.password);
      if(user != null) {
        await storage.write(key: 'userId', value: user.id.toString());
      }
      user != null ? emit(Authenticated(user)) : emit(ErrorAuthenticated());
    });

    on<SocialAuthenticate>((event, emit) async {
      User? user = await authRepository.socialAuthenticate();
      user != null ? emit(Authenticated(user)) : emit(ErrorAuthenticated());
    });

    on<Logout>((event, emit) async {
      if(await storage.read(key: 'userId') != null) {
        storage.delete(key: 'userId');
      }
      emit(UnAuthenticated());
    });
  }
}
