import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/ticket/ticket_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Pages/messages/widgets/chat.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Nachrichten',
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('helperUsers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.lightGreen[400],
                  ),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) =>
                    buildItem(context, snapshot.data.documents[index]),
                itemCount: snapshot.data.documents.length,
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if ((document['uid'] ==
            BlocProvider.of<UserBloc>(context).state.helperUser.uid) ||
        checkIfNotHelper(document)) {
      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: document['imagePath'] != null
                    ? CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.lightGreen[400],
                            ),
                          ),
                          width: 50.0,
                          height: 50.0,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: document['imagePath'],
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: Colors.grey,
                      ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Nickname: ${document['name']}',
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'About me: ${document['aboutMe'] ?? 'Not available'}',
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          peerId: document.documentID,
                          peerAvatar: document['imagePath'],
                        )));
          },
          color: Colors.grey,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  bool checkIfNotHelper(DocumentSnapshot document) {
    var notHelper = true;
    var id = document['uid'];
    for (var ticket in BlocProvider.of<TicketBloc>(context).state.ticketList) {
      if ((id == ticket.helperId &&
              ticket.authorId ==
                  BlocProvider.of<UserBloc>(context).state.helperUser.uid) ||
          (id == ticket.authorId &&
              ticket.helperId ==
                  BlocProvider.of<UserBloc>(context).state.helperUser.uid)) {
        notHelper = false;
      }
    }
    return notHelper;
  }
}
