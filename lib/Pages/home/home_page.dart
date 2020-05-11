import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:homehelper/Modules/Ticket/model/ticket.dart';
import 'widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Home Helper'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.black,
              onPressed: () => Navigator.pushNamed(context, homeSettingsRoute),
            ),
          ],
        ),
        body: Center(
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('tickets').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('loading...');
                  case ConnectionState.none:
                    return Center(child: Text('No data'));
                  default:
                    return ListView(
                      children: snapshot.data.documents
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
        floatingActionButton: FloatingActionButton(
          mini: true,
          foregroundColor: Colors.black,
          onPressed: () => Navigator.of(context).pushNamed(createTicketRoute),
          tooltip: 'Add Ticket',
          child: Icon(Icons.add),
        ),
      );
}
