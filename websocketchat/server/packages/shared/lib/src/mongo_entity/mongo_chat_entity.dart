import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../convertors/objectid_covertor.dart';
import './base_entity.dart';

part 'mongo_chat_entity.g.dart';

@JsonSerializable(converters: [ObjectIdConvertor()])
class MongoChatEntity extends BaseEntity {
  final String group;
  final String username;
  final String chatData;
  final DateTime chatTime;

  MongoChatEntity({
    required super.id,
    required this.group,
    required this.username,
    required this.chatData,
    required this.chatTime,
  });

  factory MongoChatEntity.fromJson(Map<String, dynamic> json) =>
      _$MongoChatEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MongoChatEntityToJson(this);
}
