part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  TicketState _getNextState(TicketBloc bloc);

  Future<void> _performAction(TicketBloc bloc);

  @override
  List<Object> get props => [];
}

class AppStartedTicketEvent extends TicketEvent {
  @override
  AppStartedTicketState _getNextState(TicketBloc bloc) =>
      AppStartedTicketState();

  @override
  Future<void> _performAction(TicketBloc bloc) async {
    bloc.add(TicketIdleEvent());
  }
}

/// A [TicketEvent] that is called when Loading the List of [Ticket]
/// from Backend
class LoadingEvent extends TicketEvent {
  @override
  TicketLoadingState _getNextState(TicketBloc bloc) => TicketLoadingState();

  @override
  Future<void> _performAction(TicketBloc bloc) async {
    return null;
  }
}

/// A [TicketEvent] that is called when adding a [Ticket] the List of [Ticket]
/// from Backend
class TicketAddEvent extends TicketEvent {
  final Ticket ticket;

  TicketAddEvent({@required this.ticket});
  @override
  TicketAddState _getNextState(TicketBloc bloc) => TicketAddState();

  @override
  Future<void> _performAction(TicketBloc bloc) async {
    Firestore.instance.collection('tickets').add({
      'ticketName': ticket.ticketName,
      'topic': ticket.topic,
      'description': ticket.description,
      'authorId': ticket.authorId,
      'authorName': ticket.authorName,
      'helperId': '',
    });
  }
}

/// A [TicketEvent] that is called when modifying a [Ticket] from the List of
/// [Ticket] from Backend
class TicketModifyEvent extends TicketEvent {
  @override
  TicketModifyState _getNextState(TicketBloc bloc) => TicketModifyState();

  @override
  Future<void> _performAction(TicketBloc bloc) async {
    // TODO: implement _performAction
    return null;
  }
}

/// A [TicketEvent] that is called when deleting a [Ticket] from the List of
/// [Ticket] from Backend
class TicketDeleteEvent extends TicketEvent {
  @override
  TicketDeleteState _getNextState(TicketBloc bloc) => TicketDeleteState();

  @override
  Future<void> _performAction(TicketBloc bloc) {
    // TODO: implement _performAction
    return null;
  }
}

/// A [TicketEvent] that is called when Loading the List of [Ticket]
/// from Backend is finished and successful
class TicketIdleEvent extends TicketEvent {
  @override
  TicketIdleState _getNextState(TicketBloc bloc) => TicketIdleState();

  @override
  Future<void> _performAction(TicketBloc bloc) async {
    return null;
  }
}
