import 'package:json_annotation/json_annotation.dart';

part 'create_group_dto.g.dart';

@JsonSerializable()
class CreateGroupDto {
  @JsonKey(name: "groupId")
  final String groupId;
  @JsonKey(name: "groupName")
  final String groupName;
  @JsonKey(name: "totalUser")
  final int totalUser;
  @JsonKey(name: "isGroup")
  final int isGroup;

  CreateGroupDto({
    required this.groupId,
    required this.groupName,
    required this.totalUser,
    required this.isGroup
  });

  factory CreateGroupDto.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupDtoToJson(this);
}
