import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/responses/api_expection.dart';
import 'package:server/respository/repository.dart';
import 'package:shared/shared.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  final listResponse = await context.read<RoomOperations>().getAllRoom();

  return Response.json(body: json.encode(listResponse.map((e) =>
      RoomDto.fromModel(e).toJson()).toList()));
}