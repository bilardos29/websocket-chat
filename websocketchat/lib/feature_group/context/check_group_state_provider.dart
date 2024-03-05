import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './group_join_notifer.dart';
import '../repository/group_repo.dart';

class CheckGroupStateNotifier extends StateNotifier<Resource<CheckGroupModel>> {
  CheckGroupStateNotifier(this._repo) : super(Resource.loading());

  final GroupRepo _repo;
  final GroupJoinNotifier _notifier = GroupJoinNotifier();

  GroupJoinNotifier get joinRoomNotifier => _notifier;

  void _onSuccess(CheckGroupModel data, String? _) =>
      data.state == GroupState.joinable ? _notifier.allowJoin() : null;

  void checkGroup({required String group}) {
    // Clears the able to join the room
    _notifier.reset();

    _repo.checkGroup(group).listen((event) => state = event,
        onDone: () =>
            state.maybeWhen(success: _onSuccess, orElse: _notifier.reset),
        onError: (_) => _notifier.reset());
  }
}
