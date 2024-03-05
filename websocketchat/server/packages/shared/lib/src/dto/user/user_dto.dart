import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../shared.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'fullname')
  final String fullname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: "profile_picture")
  final String profilePicture;

  UserDto(
      {
      this.id,
      required this.username,
      required this.fullname,
      required this.email,
      required this.phone,
      required this.profilePicture});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromModel(UserModel user) => UserDto(
        id: user.id,
        username: user.username,
        fullname: user.fullname,
        email: user.email,
        phone: user.phone,
        profilePicture: user.profilePicture,
      );

  factory UserDto.fromEntity(MongoUserEntity user) => UserDto(
        id: user.id.$oid,
        username: user.username,
        fullname: user.fullname,
        email: user.email,
        phone: user.phone,
        profilePicture: user.profilePicture,
      );

  MongoUserEntity toEntity() => MongoUserEntity(
        id: ObjectId.fromHexString(id!),
        username: username,
        fullname: fullname,
        email: email,
        phone: phone,
        profilePicture: profilePicture,
      );

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserModel toModel() => UserModel(
        id: id,
        username: username,
        fullname: fullname,
        email: email,
        phone: phone,
        profilePicture: profilePicture,
      );
}
