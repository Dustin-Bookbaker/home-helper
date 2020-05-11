part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];

  UserState _getNextState(UserBloc userBloc);

  Future<void> _performAction(UserBloc userBloc);
}

class AppStartedUserEvent extends UserEvent {
  @override
  AppStartedUserState _getNextState(UserBloc userBloc) => AppStartedUserState();

  @override
  Future<void> _performAction(UserBloc userBloc) async {
    try {
      final isSignedIn = await userBloc._userRepository.isSignedIn();
      if (isSignedIn) {
        userBloc.add(UserLoginEvent());
      }
    } catch (_) {}
  }
}

class UserLoginEvent extends UserEvent {
  @override
  UserLoginState _getNextState(UserBloc userBloc) => UserLoginState();

  @override
  Future<void> _performAction(UserBloc userBloc) async {
    var uid = await userBloc._userRepository.getUser();
    DocumentSnapshot userDocument;
    await Firestore.instance
        .collection('helperUsers')
        .where('uid', isEqualTo: uid.toString())
        .getDocuments()
        .then((event) {
      if (event.documents.isNotEmpty) {
        print('found something!!');
        userDocument = event.documents.single;
      } else {
        print('found nothing :(');
      }
    }).then((_) => userBloc.add(UserCreateEvent(document: userDocument)));
  }
}

class UserCreateEvent extends UserEvent {
  final DocumentSnapshot document;

  UserCreateEvent({@required this.document});
  @override
  UserCreateState _getNextState(UserBloc userBloc) => UserCreateState();

  @override
  Future<void> _performAction(UserBloc userBloc) async {
    HelperUser helperUser = HelperUser.fromDocument(document);
    userBloc.add(UserIdleEvent(helperUser: helperUser));
  }
}

class UserIdleEvent extends UserEvent {
  final HelperUser helperUser;

  UserIdleEvent({@required this.helperUser});
  @override
  UserIdleState _getNextState(UserBloc userBloc) => UserIdleState(helperUser);

  @override
  Future<void> _performAction(UserBloc userBloc) {
    return null;
  }
}
