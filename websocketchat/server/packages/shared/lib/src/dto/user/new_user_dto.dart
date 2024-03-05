import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/models/user_model.dart';

part 'new_user_dto.g.dart';

@JsonSerializable()
class NewUserDto {
  final String id;
  final String username;
  final String fullname;
  final String email;
  final String phone;
  final String profilePicture;

  NewUserDto({
    required this.id,
    required this.username,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.profilePicture,
  });

  factory NewUserDto.fromJson(Map<String, dynamic> json) =>
      _$NewUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewUserDtoToJson(this);

  factory NewUserDto.fromModel(UserModel model) => NewUserDto(
    id: model.id!,
    username: model.username,
    fullname: model.fullname,
    email: model.email,
    phone: model.phone,
    profilePicture: model.profilePicture,
  );

  UserModel toModel() => UserModel(
    id: id,
    username: username,
    fullname: fullname,
    email: email,
    phone: phone,
    profilePicture: profilePicture,
  );

}
