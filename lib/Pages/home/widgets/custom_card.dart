import 'package:flutter/material.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:homehelper/Modules/Ticket/model/ticket.dart';

class TicketCard extends StatelessWidget {
  TicketCard({@required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ticketRoute, arguments: ticket);
            },
            child: Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Text(
                        ticket.ticketName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Text(
                        ticket.topic,
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
                          Text(ticket.authorName)
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
