import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared.dart';

part 'check_group_model.freezed.dart';

@freezed
class CheckGroupModel with _$CheckGroupModel {
  factory CheckGroupModel({
    required GroupState state,
    GroupModel? room,
  }) = _CheckGroupModel;
}
