import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Pages/profile/model/helper_user.dart';
import 'package:homehelper/repositories/user/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  get initialState {
    Future(() => add(AppStartedUserEvent()));
    return InitialUserState();
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    yield event._getNextState(this);
    event._performAction(this);
  }
}
