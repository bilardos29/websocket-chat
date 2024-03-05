import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './room_join_notifer.dart';
import '../repository/room_repo.dart';

class GetAllRoomStateProvider extends StateNotifier<Resource<List<RoomModel>>> {
  GetAllRoomStateProvider(this._repo) : super(Resource.loading());

  final RoomRepo _repo;
  final RoomJoinNotifier _notifier = RoomJoinNotifier();

  RoomJoinNotifier get joinRoomNotifier => _notifier;

  void _onSuccess(List<RoomModel> data, String? _) {}

  void getAllRoom() {
    // Clears the able to join the room
    _notifier.reset();

    _repo.getAllRoom().listen((event) => state = event,
        onDone: () =>
            state.maybeWhen(success: _onSuccess, orElse: _notifier.reset),
        onError: (_) => _notifier.reset());
  }
}

