part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email});

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends RegisterEvent {
  final String userName;
  final String email;
  final String password;

  Submitted(
      {@required this.userName, @required this.email, @required this.password});

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
