import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';

@freezed
class ChatModel with _$ChatModel {
  factory ChatModel({
    String? id,
    required String group,
    required String username,
    required String chatData,
    required DateTime chatTime,
  }) = _ChatModel;
}
