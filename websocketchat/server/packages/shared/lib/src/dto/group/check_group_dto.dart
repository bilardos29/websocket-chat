import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

part 'check_group_dto.g.dart';

@JsonSerializable()
class CheckGroupDto {
  @JsonKey(name: "state")
  final GroupState state;

  @JsonKey(name: "group")
  final GroupDto? room;

  CheckGroupDto({required this.state, this.room});

  factory CheckGroupDto.fromJson(Map<String, dynamic> json) =>
      _$CheckGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckGroupDtoToJson(this);

  factory CheckGroupDto.fromModel(CheckGroupModel model) => CheckGroupDto(
        state: model.state,
        room: model.room != null ? GroupDto.fromModel(model.room!) : null,
      );

  CheckGroupModel toModel() =>
      CheckGroupModel(state: state, room: room?.toModel());
}
