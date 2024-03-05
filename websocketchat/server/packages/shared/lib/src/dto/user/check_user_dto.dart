import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

part 'check_user_dto.g.dart';

@JsonSerializable()
class CheckUserDto {
  @JsonKey(name: "state")
  final UserState state;

  @JsonKey(name: "user")
  final UserDto? user;

  CheckUserDto({required this.state, this.user});

  factory CheckUserDto.fromJson(Map<String, dynamic> json) =>
      _$CheckUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserDtoToJson(this);

  factory CheckUserDto.fromModel(CheckUserModel model) => CheckUserDto(
    state: model.state,
    user: model.user != null ? UserDto.fromModel(model.user!) : null,
  );

  CheckUserModel toModel() =>
      CheckUserModel(state: state, user: user?.toModel());
}
