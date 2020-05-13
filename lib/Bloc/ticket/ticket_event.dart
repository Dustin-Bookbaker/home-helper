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
      'authorImagePath': ticket.authorImagePath,
      'helperId': '',
    }).then((v) => bloc.add(TicketIdleEvent()));
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

class TicketAcceptEvent extends TicketEvent {
  final Ticket ticket;
  final String helperId;

  TicketAcceptEvent({@required this.ticket, @required this.helperId});
  @override
  TicketAcceptState _getNextState(TicketBloc bloc) => TicketAcceptState();

  @override
  Future<void> _performAction(TicketBloc bloc) async {
    if (ticket.helperId.isEmpty) {
      Firestore.instance
          .collection('tickets')
          .where('authorId', isEqualTo: ticket.authorId)
          .where('ticketName', isEqualTo: ticket.ticketName)
          .where('description', isEqualTo: ticket.description)
          .getDocuments()
          .then(
        (snapshot) {
          snapshot.documents.first.reference.updateData(
            {'helperId': helperId},
          );
        },
      ).then((v) => bloc.add(TicketIdleEvent()));
    } else {
      Firestore.instance
          .collection('tickets')
          .where('authorId', isEqualTo: ticket.authorId)
          .where('ticketName', isEqualTo: ticket.ticketName)
          .where('description', isEqualTo: ticket.description)
          .getDocuments()
          .then(
        (snapshot) {
          snapshot.documents.first.reference.updateData(
            {'helperId': ''},
          );
        },
      ).then((v) => bloc.add(TicketIdleEvent()));
    }
  }
}

/// A [TicketEvent] that is called when deleting a [Ticket] from the List of
/// [Ticket] from Backend
class TicketDeleteEvent extends TicketEvent {
  final Ticket ticket;
  TicketDeleteEvent({@required this.ticket});
  @override
  TicketDeleteState _getNextState(TicketBloc bloc) => TicketDeleteState();

  @override
  Future<void> _performAction(TicketBloc bloc) async {
    Firestore.instance
        .collection('tickets')
        .where('ticketName', isEqualTo: ticket.ticketName)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents
          .where((snapshot) {
            return (snapshot['description'] == ticket.description &&
                snapshot['topic'] == ticket.topic &&
                snapshot['authorId'] == ticket.authorId);
          })
          .first
          .reference
          .delete();
    }).then((v) => bloc.add(TicketIdleEvent()));
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
