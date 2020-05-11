part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final HelperUser helperUser;

  UserState({this.helperUser});

  UserState._fromDocument(DocumentSnapshot document)
      : helperUser = HelperUser.fromDocument(document);

  @override
  List<Object> get props => [];
}

class AppStartedUserState extends UserState {}

class InitialUserState extends UserState {}

class UserLoginState extends UserState {}

class UserCreateState extends UserState {}

class UserIdleState extends UserState {
  UserIdleState(HelperUser helperUser) : super(helperUser: helperUser);
}
