import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/responses/api_expection.dart';
import 'package:server/respository/repository.dart';
import 'package:shared/shared.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  final data = await context.request.json();
  if (data is! Map<String, dynamic>) {
    return ApiException.failedDependency(details: 'Invalid format');
  }
  final key = data.containsKey('userId');
  if (!key) {
    return ApiException.failedDependency(details: 'User Id is not provided');
  }
  final userId = data['userId'] as String;

  final check = await context.read<UserOperations>().checkUser(userId: userId);

  return Response.json(body: CheckUserDto.fromModel(check).toJson());
}
