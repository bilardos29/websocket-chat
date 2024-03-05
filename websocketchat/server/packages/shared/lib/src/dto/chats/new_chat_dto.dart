import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/models/chat_model.dart';

part 'new_chat_dto.g.dart';

@JsonSerializable()
class NewChatDto {
  final String group;
  final String username;
  final String chatData;
  final DateTime chatTime;

  NewChatDto({
    required this.group,
    required this.username,
    required this.chatData,
    required this.chatTime,
  });

  factory NewChatDto.fromJson(Map<String, dynamic> json) =>
      _$NewChatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewChatDtoToJson(this);

  factory NewChatDto.fromModel(ChatModel model) => NewChatDto(
        group: model.group,
        username: model.username,
        chatData: model.chatData,
        chatTime: model.chatTime,
      );

  ChatModel toModel() => ChatModel(
        group: group,
        username: username,
        chatData: chatData,
        chatTime: chatTime,
      );

// MongoChatEntity toEntity() => MongoChatEntity(
//     id: ObjectId.fromHexString(id), room: room, username: username, text: text, time: time);
}
