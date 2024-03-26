part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {
  final String email;
  final String password;

  Authenticate(this.email, this.password);
}

class SocialAuthenticate extends AuthenticationEvent {}

class Logout extends AuthenticationEvent {}

class GetItems extends AuthenticationEvent {}