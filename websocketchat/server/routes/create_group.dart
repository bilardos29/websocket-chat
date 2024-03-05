import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/responses/api_expection.dart';
import 'package:server/respository/repository.dart';
import 'package:shared/shared.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  final body = await context.request.json();
  if (body is! Map<String, dynamic>) {
    return ApiException.badRequest(details: 'Invalid data format');
  }
  if (!body.containsKey('name')) {
    return ApiException.badRequest(details: 'Group Name are not provided');
  }
  if (!body.containsKey('total')) {
    return ApiException.badRequest(details: 'Total users are not provided');
  }
  if (!body.containsKey('isGroup')) {
    return ApiException.badRequest(details: 'Is Group are not provided');
  }

  final responseModel = await context.read<GroupOperations>().createGroup(
        name: body['name'] as String,
        totalUser: body['total'] as int,
        isGroup: body['isGroup'] as int,
      );

  return Response.json(body: GroupDto.fromModel(responseModel).toJson());
}
