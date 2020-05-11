import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:homehelper/Bloc/ticket/ticket_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'ticket.g.dart';

/// A Ticket which will be held in [TicketState.ticketList]
/// A Ticket is an Item that users can generate to ask for help about
/// certain topics
/// It holds a [ticketName], a [topic], a [description], also it
/// will remember who opened the Ticket in the field [author] and later
/// a [helper] can be assigned.

// ignore: must_be_immutable
@JsonSerializable(nullable: false)
class Ticket extends Equatable {
  /// Fields of a Ticket.
  // Todo add List of Enum for possible tags
  final String ticketName;
  final String topic;
  final String description;
  final String authorName;
  final String authorId;
  final String helperId;

  /// Standard Constructor for a Ticket.
  Ticket({
    @required this.ticketName,
    @required this.topic,
    @required this.description,
    this.authorId,
    this.authorName,
    this.helperId,
  });

  Ticket.fromDocument(DocumentSnapshot document)
      : ticketName = document['ticketName'] ?? '',
        topic = document['topic'] ?? '',
        description = document['description'] ?? '',
        authorId = document['authorId'],
        authorName = document['authorName'],
        helperId = '';

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  // TODO: implement props
  List<Object> get props =>
      [ticketName, topic, description, authorId, authorName];
}
