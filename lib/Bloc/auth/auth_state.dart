part of 'auth_bloc.dart';

@immutable
class AuthenticationState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final String uid;

  Authenticated(this.uid);

  @override
  String toString() => 'Authenticated { displayName: $uid }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
