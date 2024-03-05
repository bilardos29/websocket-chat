import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../shared.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class ChatDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: "group")
  final String group;
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "chatData")
  final String chatData;
  @JsonKey(name: "chatTime")
  final DateTime chatTime;

  ChatDto({
    this.id,
    required this.group,
    required this.username,
    required this.chatData,
    required this.chatTime,
  });

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  factory ChatDto.fromModel(ChatModel model) => ChatDto(
        id: model.id,
        username: model.username,
        chatData: model.chatData,
        chatTime: model.chatTime,
        group: model.group,
      );

  factory ChatDto.fromEntity(MongoChatEntity entity) => ChatDto(
        id: entity.id.$oid,
        group: entity.group,
        username: entity.username,
        chatData: entity.chatData,
        chatTime: entity.chatTime,
      );

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);

  ChatModel toModel() => ChatModel(
        id: id,
        group: group,
        username: username,
        chatData: chatData,
        chatTime: chatTime,
      );

  MongoChatEntity toEntity() {
    assert(id != null, "THE ID OF AN MONOGO ENTITY OBJECT CANNOT BE NULL");
    return MongoChatEntity(
      id: ObjectId.fromHexString(id!),
      group: group,
      username: username,
      chatData: chatData,
      chatTime: chatTime,
    );
  }
}
