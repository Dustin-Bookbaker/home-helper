import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'helper_user.g.dart';

@JsonSerializable(nullable: false)
class HelperUser extends Equatable {
  // Todo Add Fields

  final String uid;
  final String name;
  final double rating;
  final int score;

  const HelperUser({
    @required this.uid,
    this.name,
    this.rating,
    this.score,
  });

  const HelperUser._anonUser(String uid)
      : uid = uid,
        name = 'Anonymous',
        rating = 0.0,
        score = 0;

  factory HelperUser.fromJson(Map<String, dynamic> json) =>
      _$HelperUserFromJson(json);

  Map<String, dynamic> toJson() => _$HelperUserToJson(this);

  @override
  String toString() => 'HelperUser: ${toJson()}';

  @override
  List<Object> get props => [uid, name];
}
