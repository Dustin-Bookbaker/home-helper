part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialTicketState extends TicketState {}

class AppStartedTicketState extends TicketState {}

class TicketLoadingState extends TicketState {}

class TicketAddState extends TicketState {}

class TicketModifyState extends TicketState {}

class TicketDeleteState extends TicketState {}

class TicketIdleState extends TicketState {}
