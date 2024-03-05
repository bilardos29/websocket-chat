import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared/shared.dart';

import '../../main.dart';
import '../data/group_api.dart';
import '../data/group_repo_impl.dart';
import '../repository/group_repo.dart';
import './check_group_state_provider.dart';
import './create_group_state_provider.dart';
import './get_all_group_state_provider.dart';

final _groupApi = Provider<GroupApi>((ref) => GroupApi());

final _groupprovider = Provider<GroupRepo>(
  (ref) => GroupRepoImpl(ref.read<GroupApi>(_groupApi)),
);

final checkRoomStateProvider = StateNotifierProvider.autoDispose
    .family<CheckGroupStateNotifier, Resource<CheckGroupModel?>, String>(
  (ref, group) {
    ref.onDispose(
      () => logger
          .shout("Check room provider with roomId:$group has been disposed"),
    );

    return CheckGroupStateNotifier(ref.read(_groupprovider))
      ..checkGroup(group: group);
  },
);

final createGroupStateProvider = StateNotifierProvider.autoDispose
    .family<CreateGroupStateNotifier, Resource<GroupModel>, int>((ref, maxCount) {
  ref.onDispose(
    () => logger.shout(
        "Creating room provider with maxcount:$maxCount has been disposed"),
  );

  return CreateGroupStateNotifier(ref.read(_groupprovider))..createGroup(maxCount);
});

final getAllGroupStateProvider = StateNotifierProvider.autoDispose
    .family<GetAllGroupStateProvider, Resource<List<GroupModel>>, String>((ref, noval) {
  ref.onDispose(
        () => logger.shout(
        "Get all room provider has been disposed"),
  );

  return GetAllGroupStateProvider(ref.read(_groupprovider))..getAllGroup();
});
