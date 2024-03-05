import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';

@freezed
class GroupModel with _$GroupModel {
  factory GroupModel({
    required String id,
    required String groupId,
    required String groupName,
    required int totalUser,
    required int isGroup,
  }) = _GroupModel;
}
