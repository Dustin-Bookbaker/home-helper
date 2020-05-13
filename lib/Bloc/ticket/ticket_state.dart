part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  final List<Ticket> ticketList;

  TicketState({this.ticketList});
  TicketState.fromList(List<Ticket> ticketList) : ticketList = ticketList;
  @override
  // TODO: implement props
  List<Object> get props => [...ticketList];
}

class InitialTicketState extends TicketState {}

class AppStartedTicketState extends TicketState {}

class TicketLoadingState extends TicketState {}

class TicketAddState extends TicketState {}

class TicketModifyState extends TicketState {}

class TicketAcceptState extends TicketState {}

class TicketDeleteState extends TicketState {}

class TicketIdleState extends TicketState {
  TicketIdleState.fromList(ticketList) : super.fromList(ticketList);
}
