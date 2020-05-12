import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:homehelper/Modules/Ticket/model/ticket.dart';
import '../ticket/widgets/ticket_card.dart';

class MyTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('tickets').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('loading...');
                    case ConnectionState.none:
                      return Center(child: Text('No data'));
                    default:
                      return ListView(
                        children: snapshot.data.documents
                            .where((snapshot) =>
                                snapshot['authorId'] ==
                                BlocProvider.of<UserBloc>(context)
                                    .state
                                    .helperUser
                                    .uid)
                            .map((DocumentSnapshot document) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            child: TicketCard(
                              ticket: Ticket.fromDocument(document),
                            ),
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          foregroundColor: Colors.black,
          onPressed: () => Navigator.of(context).pushNamed(createTicketRoute),
          tooltip: 'Ticket Hinzufügen',
          child: Icon(Icons.add),
        ),
      );
}
