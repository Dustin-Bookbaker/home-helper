import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/ticket/ticket_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Modules/Ticket/model/ticket.dart';

class TicketPage extends StatefulWidget {
  final Ticket ticket;

  const TicketPage({@required this.ticket});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(widget.ticket.ticketName),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(360)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: widget.ticket.authorImagePath != ''
                          ? Image.network(
                              widget.ticket.authorImagePath,
                              height: 50,
                              width: 50,
                            )
                          : Icon(
                              Icons.person,
                              size: 50,
                            )),
                  Container(
                    child: Text(
                      '${widget.ticket.authorName} '
                      'benötigt Hilfe mit:',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.ticket.description,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (widget.ticket.helperId == '')
                      if (widget.ticket.authorId !=
                          BlocProvider.of<UserBloc>(context)
                              .state
                              .helperUser
                              .uid)
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          color: Colors.lightGreen[400],
                          onPressed: _showAcceptDialog,
                          child: Text('Ticket annehmen'),
                        ),
                    if ((widget.ticket.helperId != '') &&
                        ((widget.ticket.authorId ==
                                BlocProvider.of<UserBloc>(context)
                                    .state
                                    .helperUser
                                    .uid) ||
                            (widget.ticket.helperId ==
                                BlocProvider.of<UserBloc>(context)
                                    .state
                                    .helperUser
                                    .uid)))
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: Colors.lightGreen[400],
                        onPressed: _showReleaseDialog,
                        child: Text('Ticket freigeben'),
                      ),
                  ],
                ),
                widget.ticket.helperName != ''
                    ? Column(
                        children: <Widget>[
                          Text(
                            '${widget.ticket.helperName} hat dieses Ticket angenommen.',
                          ),
                          Text(
                            'Unter "Nachrichten" könnt ihr euch nun austauschen.',
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
  void _showAcceptDialog() {
    print(widget.ticket.helperId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: Text('Ticket annehmen'),
        content: Text(
          'Bist du dir sicher, dass du dieses Ticket annehmen willst?',
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              BlocProvider.of<TicketBloc>(context).add(
                TicketAcceptEvent(
                  ticket: widget.ticket,
                  helperId:
                      BlocProvider.of<UserBloc>(context).state.helperUser.uid,
                  helperName:
                      BlocProvider.of<UserBloc>(context).state.helperUser.name,
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'ANNHEMEN',
              style: TextStyle(
                color: Colors.lightGreen[700],
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

  void _showReleaseDialog() {
    print(widget.ticket.helperId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: Text('Ticket freigeben'),
        content: Text(
          'Bist du dir sicher, dass du dieses Ticket freigeben willst?',
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                BlocProvider.of<TicketBloc>(context).add(TicketAcceptEvent(
                    ticket: widget.ticket,
                    helperId:
                        BlocProvider.of<UserBloc>(context).state.helperUser.uid,
                    helperName: BlocProvider.of<UserBloc>(context)
                        .state
                        .helperUser
                        .name));
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
            child: Text(
              'FREIGEBEN',
              style: TextStyle(
                color: Colors.lightGreen[700],
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
