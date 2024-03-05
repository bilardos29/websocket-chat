import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
      {
          String? id,
      required String username,
      required String fullname,
      required String email,
      required String phone,
      required String profilePicture}) = _UserModel;
}
