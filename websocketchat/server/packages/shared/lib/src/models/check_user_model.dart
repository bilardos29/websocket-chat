import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/models/user_model.dart';
import 'package:shared/src/utils/user_state.dart';

part 'check_user_model.freezed.dart';

@freezed
class CheckUserModel with _$CheckUserModel {
  factory CheckUserModel({
    required UserState state,
    UserModel? user,
  }) = _CheckUserModel;
}
