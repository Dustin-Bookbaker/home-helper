import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/ticket/ticket_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Modules/Ticket/model/ticket.dart';

class CreateTicketPage extends StatefulWidget {
  @override
  _CreateTicketPageState createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  TextEditingController ticketNameInputController = TextEditingController();
  TextEditingController ticketTopicInputController = TextEditingController();
  TextEditingController ticketDescriptionInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Erstelle ein Ticket'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Text(
                      'Wähle einen Namen für dein Ticket',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: TextField(
                      maxLines: 1,
                      maxLengthEnforced: true,
                      maxLength: 40,
                      decoration: InputDecoration(
                        labelText: 'Ticket Name',
                      ),
                      controller: ticketNameInputController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Text(
                      'Wähle ein Thema für dein Ticket',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: TextField(
                      minLines: 1,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Thema',
                      ),
                      controller: ticketTopicInputController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Text(
                      'Beschreibe dein Problem',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: TextField(
                      minLines: 1,
                      maxLines: 100,
                      decoration: InputDecoration(
                        labelText: 'Beschreibung',
                      ),
                      controller: ticketDescriptionInputController,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: Colors.lightGreen[400],
                        child: Text(
                          'Bestätigen',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          Future(
                            () => BlocProvider.of<TicketBloc>(context).add(
                              TicketAddEvent(
                                ticket: Ticket(
                                  description:
                                      ticketDescriptionInputController.text,
                                  topic: ticketTopicInputController.text,
                                  ticketName: ticketNameInputController.text,
                                  authorId: BlocProvider.of<UserBloc>(context)
                                      .state
                                      .helperUser
                                      .uid,
                                  authorName: BlocProvider.of<UserBloc>(context)
                                      .state
                                      .helperUser
                                      .name,
                                  authorImagePath:
                                      BlocProvider.of<UserBloc>(context)
                                          .state
                                          .helperUser
                                          .imagePath,
                                ),
                              ),
                            ),
                          ).then((event) => Navigator.of(context).pop());
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  @override
  void dispose() {
    ticketNameInputController.dispose();
    ticketTopicInputController.dispose();
    ticketDescriptionInputController.dispose();
    super.dispose();
  }
}
