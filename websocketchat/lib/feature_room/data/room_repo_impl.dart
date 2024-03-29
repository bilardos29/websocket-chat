import 'package:shared/shared.dart';
import 'package:flutter/material.dart';

import '../repository/room_repo.dart';
import './room_api.dart';

class RoomRepoImpl implements RoomRepo {
  final RoomApi _api;

  RoomRepoImpl(this._api);

  @override
  Stream<Resource<CheckRoomModel>> checkRoom(String room) async* {
    yield Resource.loading(message: "CHECKING YOUR ROOM");
    try {
      CheckRoomDto dto = await _api.checkRoom(room);
      yield Resource.success(data: dto.toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }

  @override
  Stream<Resource<RoomModel>> createRoom(int max) async* {
    yield Resource.loading(message: "CREATING YOUR ROOM");
    try {
      RoomDto dto = await _api.createRoom(max);
      yield Resource.success(
          data: dto.toModel(), message: "Your room id has been created");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }

  @override
  Stream<Resource<List<RoomModel>>> getAllRoom() async* {
    yield Resource.loading(message: "GET ALL ROOM");
    try {
      List<RoomDto> listDto = await _api.getAllRoom();
      List<RoomModel> listModel = listDto.map((data) => data.toModel()).toList();
      yield Resource.success(
          data: listModel);
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }
}
