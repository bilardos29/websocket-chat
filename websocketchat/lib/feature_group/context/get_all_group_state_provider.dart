import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './group_join_notifer.dart';
import '../repository/group_repo.dart';

class GetAllGroupStateProvider extends StateNotifier<Resource<List<GroupModel>>> {
  GetAllGroupStateProvider(this._repo) : super(Resource.loading());

  final GroupRepo _repo;
  final GroupJoinNotifier _notifier = GroupJoinNotifier();

  GroupJoinNotifier get joinGroupNotifier => _notifier;

  void _onSuccess(List<GroupModel> data, String? _) {}

  void getAllGroup() {
    // Clears the able to join the room
    _notifier.reset();

    _repo.getAllGroup().listen((event) => state = event,
        onDone: () =>
            state.maybeWhen(success: _onSuccess, orElse: _notifier.reset),
        onError: (_) => _notifier.reset());
  }
}

