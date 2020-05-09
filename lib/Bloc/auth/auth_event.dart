part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
