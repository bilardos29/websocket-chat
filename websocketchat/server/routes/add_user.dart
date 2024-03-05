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
  if (!body.containsKey('username')) {
    return ApiException.badRequest(details: 'Username are not provided');
  }
  if (!body.containsKey('fullname')) {
    return ApiException.badRequest(details: 'Fullname are not provided');
  }
  if (!body.containsKey('email')) {
    return ApiException.badRequest(details: 'Email are not provided');
  }
  if (!body.containsKey('phone')) {
    return ApiException.badRequest(details: 'Phone are not provided');
  }
  if (!body.containsKey('profilePicture')) {
    return ApiException.badRequest(details: 'Profile Picture are not provided');
  }

  final responseModel = await context.read<UserOperations>().addUser(
      user: UserModel(
          username: body['username'] as String,
          fullname: body['fullname'] as String,
          email: body['email'] as String,
          phone: body['phone'] as String,
          profilePicture: body['profilePicture'] as String));

  return Response.json(body: UserDto.fromModel(responseModel).toJson());
}
