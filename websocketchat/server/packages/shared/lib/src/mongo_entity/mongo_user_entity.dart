import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../convertors/objectid_covertor.dart';
import './base_entity.dart';

part 'mongo_user_entity.g.dart';

///These classes will be same as the dto object
@JsonSerializable(converters: [ObjectIdConvertor()])
class MongoUserEntity extends BaseEntity {

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'fullname')
  final String fullname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: "profile_picture")
  final String profilePicture;

  MongoUserEntity({
    required super.id,
    required this.username,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.profilePicture,
  });

  factory MongoUserEntity.fromJson(Map<String, dynamic> json) =>
      _$MongoUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MongoUserEntityToJson(this);
}
