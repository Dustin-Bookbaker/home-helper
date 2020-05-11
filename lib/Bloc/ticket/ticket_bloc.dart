import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Modules/Ticket/model/ticket.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState {
    Future(() => add(AppStartedTicketEvent()));
    return InitialTicketState();
  }

  @override
  Stream<TicketState> mapEventToState(TicketEvent event) async* {
    yield event._getNextState(this);
    event._performAction(this);
  }
}
