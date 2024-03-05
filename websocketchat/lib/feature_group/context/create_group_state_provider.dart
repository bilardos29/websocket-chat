import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/group_repo.dart';
import './group_join_notifer.dart';

class CreateGroupStateNotifier extends StateNotifier<Resource<GroupModel>> {
  CreateGroupStateNotifier(this._repo) : super(Resource.loading());

  final GroupRepo _repo;
  final GroupJoinNotifier _notifier = GroupJoinNotifier();

  GroupJoinNotifier get joinRoomNotifier => _notifier;

  void _onSuccess(GroupModel data, String? _) => _notifier.allowJoin();

  void createGroup(int max) {
    _notifier.reset();
    _repo.createGroup(max).listen(
          (event) => state = event,
          onDone: () =>
              state.maybeWhen(success: _onSuccess, orElse: _notifier.reset),
          onError: (_) => _notifier.reset(),
        );
  }
}
