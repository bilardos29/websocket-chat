import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared/shared.dart';

import '../../utils.dart';

class RoomApi {
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

  Future<RoomDto> createRoom(int max) async {
    Response resp = await _dio.post(
      '/create_room',
      data: jsonEncode(<String, int>{"max": max}),
    );
    return RoomDto.fromJson(resp.data);
  }

  Future<CheckRoomDto> checkRoom(String room) async {
    Response resp = await _dio.post(
      '/check_room',
      data: jsonEncode(<String, String>{"roomId": room}),
    );
    print("berhasil checkroom $resp");
    return CheckRoomDto.fromJson(resp.data);
  }

  Future<List<RoomDto>> getAllRoom() async {
    Response resp = await _dio.post(
      '/get_all_room',
    );

    return List<RoomDto>.from(json.decode(resp.data)
        .map((data) {
          RoomDto item = RoomDto.fromJson(data);
          return item;
        }));
  }
}
