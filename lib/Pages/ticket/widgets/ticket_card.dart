import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/ticket/ticket_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:homehelper/Modules/Ticket/model/ticket.dart';

class TicketCard extends StatefulWidget {
  TicketCard({@required this.ticket});

  final Ticket ticket;

  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 5,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 12,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ticketRoute, arguments: widget.ticket);
                        },
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Text(
                                widget.ticket.ticketName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Text(
                                widget.ticket.topic,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: <Widget>[
                                  Text('Author: '),
                                  Text(widget.ticket.authorName)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    state.helperUser.uid == widget.ticket.authorId
                        ? Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 45),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  IconButton(
                                    color: Colors.blueGrey[700],
                                    iconSize: 20,
                                    icon: Icon(Icons.delete),
                                    onPressed: _showDeleteDialog,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )),
          ),
        ));
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: Text('Ticket löschen'),
        content:
            Text('Bist du dir sicher, dass du dein Ticket löschen willst?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              BlocProvider.of<TicketBloc>(context)
                  .add(TicketDeleteEvent(ticket: widget.ticket));
              Navigator.pop(context);
            },
            child: Text(
              'LÖSCHEN',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 15.0,
              ),
            ),
          ),
          FlatButton(
            child: Text(
              'ABBRECHEN',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.blueGrey[700],
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
