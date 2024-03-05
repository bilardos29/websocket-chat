import 'package:shared/shared.dart';
import 'package:flutter/material.dart';

import '../repository/group_repo.dart';
import './group_api.dart';

class GroupRepoImpl implements GroupRepo {
  final GroupApi _api;

  GroupRepoImpl(this._api);

  @override
  Stream<Resource<CheckGroupModel>> checkGroup(String group) async* {
    yield Resource.loading(message: "CHECKING YOUR GROUP");
    try {
      CheckGroupDto dto = await _api.checkGroup(group);
      yield Resource.success(data: dto.toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }

  @override
  Stream<Resource<GroupModel>> createGroup(int max) async* {
    yield Resource.loading(message: "CREATING YOUR GROUP");
    try {
      GroupDto dto = await _api.createGroup(max);
      yield Resource.success(
          data: dto.toModel(), message: "Your group has been created");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }

  @override
  Stream<Resource<List<GroupModel>>> getAllGroup() async* {
    yield Resource.loading(message: "GET ALL GROUP");
    try {
      List<GroupDto> listDto = await _api.getAllRoom();
      List<GroupModel> listModel = listDto.map((data) => data.toModel()).toList();
      yield Resource.success(
          data: listModel);
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }
}
