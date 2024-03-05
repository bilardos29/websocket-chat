import 'package:dart_frog/dart_frog.dart';
import 'package:server/middleware/db_middleware.dart';
import 'package:server/respository/repository.dart';

///Provies user fucntions
Middleware userMiddleWare() {
  return provider<UserOperations>(
        (context) => UserOperationRepoImpl(database.db),
  );
}
