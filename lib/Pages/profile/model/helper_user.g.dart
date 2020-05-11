// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelperUser _$HelperUserFromJson(Map<String, dynamic> json) {
  return HelperUser(
    uid: json['uid'] as String,
    name: json['name'] as String,
    rating: (json['rating'] as num).toDouble(),
    score: json['score'] as int,
  );
}

Map<String, dynamic> _$HelperUserToJson(HelperUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'rating': instance.rating,
      'score': instance.score,
    };
