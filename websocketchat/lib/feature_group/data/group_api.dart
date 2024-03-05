import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

import '../../utils.dart';

class GroupApi {
  static final _endpoint = 'http://192.168.23.202:8080';

  static final _dio = Dio(
    BaseOptions(
      baseUrl: _endpoint,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: 'application/json',
    ),
  );

  Future<GroupDto> createGroup(int max) async {
    Response resp = await _dio.post(
      '/create_group',
      data: jsonEncode(<String, int>{"max": max}),
    );
    return GroupDto.fromJson(resp.data);
  }

  Future<CheckGroupDto> checkGroup(String room) async {
    Response resp = await _dio.post(
      '/check_group',
      data: jsonEncode(<String, String>{"groupId": room}),
    );
    print("berhasil check group $resp");
    return CheckGroupDto.fromJson(resp.data);
  }

  Future<List<GroupDto>> getAllRoom() async {
    Response resp = await _dio.post(
      '/get_all_group',
    );

    return List<GroupDto>.from(json.decode(resp.data).map((data) {
      GroupDto item = GroupDto.fromJson(data);
      return item;
    }));
  }
}
