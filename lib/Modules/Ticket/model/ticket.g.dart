// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return Ticket(
    ticketName: json['ticketName'] as String,
    topic: json['topic'] as String,
    description: json['description'] as String,
    authorId: json['authorId'] as String,
    helperId: json['helperId'] as String,
  );
}

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'ticketName': instance.ticketName,
      'topic': instance.topic,
      'description': instance.description,
      'authorId': instance.authorId,
      'helperId': instance.helperId,
    };
