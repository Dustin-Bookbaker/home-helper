import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'helper_user.g.dart';

@JsonSerializable(nullable: false)
class HelperUser extends Equatable {
  // Todo Add Fields

  final String uid;
  final String name;
  final String email;
  final double rating;
  final int score;

  const HelperUser({
    @required this.uid,
    this.name,
    this.email,
    this.rating,
    this.score,
  });

  const HelperUser._anonUser(String uid)
      : uid = uid,
        name = 'Anonymous',
        email = '',
        rating = 0.0,
        score = 0;

  HelperUser.fromDocument(DocumentSnapshot document)
      : uid = document['uid'] ?? '',
        name = document['name'] ?? '',
        email = document['email'] ?? '',
        rating = (document['rating']).toDouble() ?? 0.0,
        score = (document['score']).toInt() ?? 0;

  factory HelperUser.fromJson(Map<String, dynamic> json) =>
      _$HelperUserFromJson(json);

  Map<String, dynamic> toJson() => _$HelperUserToJson(this);

  @override
  String toString() => 'HelperUser: ${toJson()}';

  @override
  List<Object> get props => [uid, name];
}
