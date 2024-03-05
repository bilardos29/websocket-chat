import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../shared.dart';

part 'group_dto.g.dart';

@JsonSerializable()
class GroupDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: "groupId")
  final String groupId;
  @JsonKey(name: "groupName")
  final String groupName;
  @JsonKey(name: "totalUser")
  final int totalUser;
  @JsonKey(name: "isGroup")
  final int isGroup;

  GroupDto({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.totalUser,
    required this.isGroup,
  });

  factory GroupDto.fromJson(Map<String, dynamic> json) =>
      _$GroupDtoFromJson(json);

  factory GroupDto.fromModel(GroupModel group) => GroupDto(
        id: group.id,
        groupId: group.groupId,
        groupName: group.groupName,
        totalUser: group.totalUser,
        isGroup: group.isGroup,
      );

  factory GroupDto.fromEntity(MongoGroupEntity group) => GroupDto(
        id: group.id.$oid,
        groupId: group.groupId,
        groupName: group.groupName,
        totalUser: group.totalUser,
        isGroup: group.isGroup,
      );

  MongoGroupEntity toEntity() => MongoGroupEntity(
        id: ObjectId.fromHexString(id),
        groupId: groupId,
        groupName: groupName,
        totalUser: totalUser,
        isGroup: isGroup,
      );

  Map<String, dynamic> toJson() => _$GroupDtoToJson(this);

  GroupModel toModel() => GroupModel(
        id: id,
        groupId: groupId,
        groupName: groupName,
        totalUser: totalUser,
        isGroup: isGroup,
      );
}
